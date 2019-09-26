<template>
  <b-container fluid>
    <b-row>
      <b-col class="logo" md="4" sm="6" cols="9">
        <img src="..\src\assets\logo2.jpg" class="img-fluid" alt="logo" />
      </b-col>

      <b-col md="4" sm="4" cols="12" class="d-flex justify-content-center garage mr-15">
        <h2>Garage</h2>
      </b-col>
      <b-col md="4" sm="2" cols="3" class="mr-15 right_ d-flex justify-content-end">
        <router-link
          id="linkshortQuery"
          class="btn btn-primary"
          v-show="isLoggedIn"
          to="/shortQuery"
          tag="button"
        >Заявка</router-link>
        <button v-on:click="logout" id="logout" v-show="isLoggedIn" class="btn btn-primary">Вихід</button>
      </b-col>
    </b-row>
    <router-view></router-view>
  </b-container>
</template>
<script>
import { router } from "@/_helpers";
import axios from "axios";
import { store, authstore } from "./store";
export default {
  name: "app",
  data() {
    return {};
  },
  computed: {
    isLoggedIn: function() {
      return authstore.getters.isLoggedIn;
    }
  },
  created() {},
  methods: {
    logout() {
      authstore.dispatch("logout");
      this.$router.push("/");
    }
  }
};
</script>
<style lang='scss' >
.logo {
  display: flex;
  padding: 5px;
  padding-left: 25px !important;
}
.right_ {
  display: flex;
  justify-content: end;
}
.mr-15 {
  margin-top: 15px;
}
h2 {
  font-size: 2.5rem !important ;
}
#linkshortQuery {
  display: flex;
  margin: 5px;
  height: 70%;
  background: #4b65bd !important;
  border: #4b65bd;
}
#logout {
  display: flex;
  margin: 5px;
  height: 70%;
  background: #4b65bd !important;
  border: #4b65bd;
}
@media screen and (max-width: 600px) {
  .d-flex.justify-content-center.garage {
    display: none !important;
  }
}
</style>