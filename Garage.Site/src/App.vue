<template>
  <router-view></router-view>
</template>
<script>
import { authenticationService } from "@/_services";
import { router } from "@/_helpers";
//<<<<<<< HEAD
import axios from 'axios'; 

//=======
import Detailtable from "@/TableDetails/DetailsTable";
// 0e0e15d81e933c6e8aeabf0ffdf0ebf94863045a
export default {
  name: "app",
  data() {
    return {
      currentUser: null
    };
  },
  computed: {},
  created() {
        const token = 'Bearer ' + localStorage.getItem('currentUser')
        if (token) {
          axios.defaults.headers.common['Authorization'] =  token
            //return router.push('/disposition');
        }
  },
  methods: {
    logout() {
      //authenticationService.logout();
      router.push("/login");
    }
  }
};
</script>