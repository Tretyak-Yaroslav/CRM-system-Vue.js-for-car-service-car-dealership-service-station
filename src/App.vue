<template>
  <router-view></router-view>
</template>
<script>
import { authenticationService } from "@/_services";
import { router } from "@/_helpers";

export default {
  name: "app",
  data() {
    return {
      currentUser: null
    };
  },
  computed: {},
  created() {
    authenticationService.currentUser.subscribe(x => (this.currentUser = x));
  },
  methods: {
    logout() {
      authenticationService.logout();
      router.push("/login");
    }
  }
};
</script>