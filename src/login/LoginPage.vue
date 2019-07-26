<template>
  <b-container class="bv-example-row bv-example-row-flex-cols">
  <b-row align-v="center" >
  <div class="login col-md-8 offset-md-2">
  <div v-if="loading" class="container-loading">
  <img src="/loading.gif" alt="Loading Icon" class="loader-img">
  </div>
    <p class="errorMsg">{{ error }}</p>
  <form @submit.prevent="onSubmit" >
            <input type="text" class="form-control mr-15" placeholder="User Name" v-model="username">
            <input type="password" class="form-control mr-15" placeholder="Password" v-model="password">
            <button type="submit" class="btn btn-primary offset-md-10 mr-15">Login</button>
  </form>
    </div>
  </b-row>
  </b-container>
</template>
<script>
import { required } from 'vuelidate/lib/validators';
import { router } from '@/_helpers';
import { authenticationService } from '@/_services';
export default {
    data () {
        return {
            username: '',
            password: '',
            submitted: false,
            loading: false,
            returnUrl: '',
            error: ''
        };
    },
    validations: {
      username: { required },
      password: { required }
    },
    created () {
        if (authenticationService.currentUserValue) {
            return router.push('/');
        }
        this.returnUrl = this.$route.query.returnUrl || '/';
    },
    methods: {
        onSubmit () {
            this.submitted = true;

            this.loading = true;
            authenticationService.login(this.username, this.password)
                .then(
                    user => router.push(this.returnUrl),
                    error => {
                        this.error = "Somethsomething went wrong!";
                        this.loading = false;
                    }
                );
        }
    }
}; 
</script>

<style>
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
.mr-15{
  margin-top: 15px;
  
}
</style>