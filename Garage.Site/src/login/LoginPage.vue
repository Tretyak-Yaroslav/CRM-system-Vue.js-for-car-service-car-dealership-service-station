<template>
  <b-container class="bv-example-row bv-example-row-flex-cols">
    <b-row align-v="center">
      <div class="login col-md-8 offset-md-3">
        <!-- <div v-if="loading" class="container-loading">
          <img src="/loading.gif" alt="Loading Icon" class="loader-img" />
        </div>-->

        <form @submit.prevent="onSubmit">
          <b-row>
            <div class="col-12">
              <input type="text" class="form-control mr-15" placeholder="Login" v-model="username" />
              <input
                type="password"
                class="form-control mr-15"
                placeholder="Password"
                v-model="password"
              />
              <p class="errorMsg">{{ error }}</p>
              <a href="#" v-b-modal="'modal-resetpass'">Забув логин/пароль</a>
            </div>
            <div class="col-12 d-flex justify-content-end">
              <button type="submit" class="btn btn-primary mr-15">ВХІД</button>
            </div>
          </b-row>
        </form>
      </div>
    </b-row>
    <b-modal id="modal-resetpass" ref="resetpass-modal" centered title="Створення нового пароля">
      <form @submit.prevent="onSubmitResetPass">
        <b-form-input required placeholder="Введіть адресу email" v-model="resetemail" />
        <b-button
          v-if="!passwordreseted"
          type="submit"
          class="btn btn-primary mr-15"
        >Вiдправити новий пароль</b-button>
        <div v-if="emailerror">
          <b>Вказаного email не знайдено</b>
        </div>
        <div v-if="!emailerror && passwordreseted">
          <b>Новий пароль вiдправлено</b>
        </div>
      </form>
    </b-modal>
  </b-container>
</template>
<script>
import { required } from "vuelidate/lib/validators";
import axios from "axios";
import { store, authstore } from "../store";
//import { router } from '@/_helpers';
//import { authenticationService } from '@/_services';
export default {
  data() {
    return {
      username: "",
      password: "",
      submitted: false,
      loading: false,
      returnUrl: "",
      error: "",
      resetemail: "",
      passwordreseted: false,
      emailerror: false
    };
  },
  validations: {
    username: { required },
    password: { required }
  },
  beforeCreate() {
    if(authstore.getters.isLoggedIn)
       this.$router.push("/disposition");
  },
  methods: {
    onSubmit() {
      return new Promise((resolve, reject) => {
        this.submitted = true;
        this.loading = true;
        authstore.commit("auth_request");
        this.$store
          .dispatch("Login", {
            params: {
              workShopID: 1,
              employeeLogin: this.username,
              employeePwd: this.password
            }
          })
          .then(res => {
            if (res.status == 200) {
              localStorage.setItem("currentUser", JSON.stringify(res.data));
              authstore.commit("auth_success", res.data);
              axios.defaults.headers.common["Authorization"] =
                "Bearer " + res.data.token;
              this.loading = false;
              this.$router.push("/disposition");
              resolve(res);
            }
          })
          .catch(error => {
            this.loading = false;
            authstore.commit("auth_error", error);
            localStorage.removeItem("currentUser");
            this.error = "Ви ввели некоректні дані!";
            reject(error);
          });
      });
    },
     onSubmitResetPass (){
           return new Promise ((resolve,reject) => {
            this.$store
              .dispatch("GeneratePassword", {
                params: {
                email: this.resetemail
                }                
              }).then(res => {
              var validEmail = JSON.parse(JSON.stringify(res.data)); 
              if (!validEmail) {
                       this.emailerror = true;
                       resolve(res)
              }
              else {
                    this.passwordreseted = true;
                    this.emailerror = false;
                    resolve(res)
                } 
              }).catch(error =>{
                    this.$refs['resetpass-modal'].hide();
                    this.error = "Щось пішло не так!";
                    reject(error)
              })
          });
      
    }
  }
};
</script>
<style lang="scss" scoped>
form {
  padding: 20px 50px;
}
form[data-v-65282689] {
  max-width: 550px;
}
.errorMsg {
  margin-top: 10px;
  margin-bottom: 0px;
  color: red;
}
.btn-primary {
  background: #4b65bd !important;
  border: #4b65bd;
  padding-left: 25px;
  padding-right: 25px;
  font-weight: 600;
}
.form-elegant .font-small {
  font-size: 0.8rem;
}
.form-elegant .z-depth-1a {
  -webkit-box-shadow: 0 2px 5px 0 rgba(55, 161, 255, 0.26),
    0 4px 12px 0 rgba(121, 155, 254, 0.25);
  box-shadow: 0 2px 5px 0 rgba(55, 161, 255, 0.26),
    0 4px 12px 0 rgba(121, 155, 254, 0.25);
}
.form-elegant .z-depth-1-half,
.form-elegant .btn:hover {
  -webkit-box-shadow: 0 5px 11px 0 rgba(85, 182, 255, 0.28),
    0 4px 15px 0 rgba(36, 133, 255, 0.15);
  box-shadow: 0 5px 11px 0 rgba(85, 182, 255, 0.28),
    0 4px 15px 0 rgba(36, 133, 255, 0.15);
}
.mr-15 {
  margin-top: 15px;
}
form {
  max-width: 600px;
}
@media screen and (max-width: 415px) {
  form {
    padding: 10px;
  }
}
</style>