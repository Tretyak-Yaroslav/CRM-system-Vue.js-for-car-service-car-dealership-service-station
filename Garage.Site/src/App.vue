<template>
  <b-container fluid>
    <b-row>
      <b-col class="logo" md="4" sm="6" cols="9">
        <img src="..\src\assets\logo2.jpg" class="img-fluid" alt="logo" />
      </b-col>

      <b-col md="4" sm="4" cols="12" class="d-flex justify-content-center garage">
        <!-- <h2>Garage</h2> -->
      </b-col>
      <b-col md="4" sm="2" cols="3" class="pr-25 right_ d-flex justify-content-end">
        <div v-if="isLoggedIn" class="col-12 user_text">
          <font color="gray">{{getUserNameLabel()}}</font>
        </div>

        <!-- <router-link
          id="linkshortQuery"
          class="btn btn-primary"
          v-show="isLoggedIn"
          to="/shortQuery"
          tag="button"
        >Заявка</router-link>-->
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
  computed: {
    isLoggedIn: function() {
      return authstore.getters.isLoggedIn;
    }
  },
  created() {
    document.title = process.env.VUE_APP_TITLE
  },
  methods: {
    logout() {

      authstore.dispatch("logout");
      this.$router.push("/");
    }
  }
};
function getCookie(currentUserName) {
  let matches = document.cookie.match(
    new RegExp(
      "(?:^|; )" +
        currentUserName.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, "\\$1") +
        "=([^;]*)"
    )
  );
  return matches ? decodeURIComponent(matches[1]) : undefined;
}

function setCookie(currentUserName, value, options = {}) {
  options = {
    path: "/"
  };

  if (options.expires.toUTCString) {
    options.expires = options.expires.toUTCString();
  }

  let updatedCookie =
    encodeURIComponent(currentUserName) + "=" + encodeURIComponent(value);

  for (let optionKey in options) {
    updatedCookie += "; " + optionKey;
    let optionValue = options[optionKey];
    if (optionValue !== true) {
      updatedCookie += "=" + optionValue;
    }
  }
  document.cookie = updatedCookie;
}

function deleteCookie(currentUserName) {
  setCookie(currentUserName, "", {
    "max-age": -1
  });
}
</script>

<style lang='scss' >
.logo {
  display: flex;
  padding: 5px;
  padding-bottom: 0px;
  padding-left: 25px !important;
  position: relative;
  overflow: hidden;
  margin-top: -15px;
}
.pr-25 {
  padding-right: 25px !important;
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
.user_text {
  text-align: end;
  margin-top: 11px;
}
#linkshortQuery {
  display: flex;
  margin: 8px;

  background: #4b65bd !important;
  border: #4b65bd;
}
#logout {
  display: flex;
  margin-top: 5px;
  margin-bottom: 5px;
  background: #4b65bd !important;
  border: #4b65bd;
}
@media screen and (max-width: 600px) {
  .d-flex.justify-content-center.garage {
    display: none !important;
  }
}
@media screen and (max-width: 768px) {
  .user_text {
    margin-top: 5px;
  }
}
@import "node_modules/bootstrap/scss/bootstrap";
@import "node_modules/bootstrap-vue/src/index.scss";
</style>