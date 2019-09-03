<template>
<b-container fluid>
      <b-row>
        <b-col class="logo" md="1" sm="2" cols="2">
          <img src="..\src\assets\logo_ad.png" alt="logo" />
        </b-col>
        <b-col md="10" sm="8" cols="7" class="d-flex justify-content-center">
          <h2>Garage</h2>
        </b-col>
        <b-col md="1" sm="2" cols="3">
          <button v-on:click="logout" id="logout" v-show="isLoggedIn" class="btn btn-primary">Вихід</button>
        </b-col>
      </b-row>
  <router-view>
  </router-view>
  </b-container>
</template>
<script>
//import { authenticationService } from "@/_services";
import { router } from "@/_helpers";
import axios from 'axios'; 
import DetailsTable from '../src/TableDetails/DetailsTable';
import { Component } from '@fullcalendar/core';
import { store,authstore } from './store'
export default  {
  name: "app",
  data() {
    return {
      //IsAuth: true
      //currentUser: JSON.parse(localStorage.getItem('currentUser'))
    };

   Component({
      components:{DetailsTable},
    }) 
  },
  computed: {
    isLoggedIn : function(){ return authstore.getters.isLoggedIn}
  },
  created() {
        const currentUser = JSON.parse(localStorage.getItem('currentUser'));
        // const t = authstore.state.currentUser;
        // const ttt =  authstore.getters.isLoggedIn;
        //this.$store.currentUser = JSON.parse(localStorage.getItem('currentUser'));
        if (currentUser) {
          axios.defaults.headers.common['Authorization'] = 'Bearer ' + currentUser.token
        }
        axios.interceptors.response.use(undefined, function (err) {
          return new Promise(function (resolve, reject) {
            if (err.response.status === 401 && err.config && !err.config.__isRetryRequest) {
              authstore.dispatch("logout");
              this.$router.push('/');
            }
            throw err;
      });
    });

  },
  methods: {
    logout(){
      authstore.dispatch("logout");
      this.$router.push('/');
    },
  }
};
</script>
<style lang='scss'>
.logo {
  display: flex;
padding: 5px;
    padding-left: 25px !important;
}

#logout{
  display: flex;
  //padding: 10px;
  margin: 5px;
}
</style>