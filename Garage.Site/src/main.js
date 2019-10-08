import Vuex from 'vuex'
import Vue from 'vue'
import App from './App.vue'
import { router } from './_helpers'
import axios from 'axios'
import VueAxios from 'vue-axios'
import { store, authstore } from './store'
import 'vue-datetime/dist/vue-datetime.css'
import BootstrapVue from 'bootstrap-vue'
import VueI18n from 'vue-i18n'

Vue.config.productionTip = false;
Vue.use(VueI18n)
Vue.use(VueAxios, axios)
Vue.use(Vuex)

Vue.use(BootstrapVue)
Vue.config.productionTip = false

const currentUser = JSON.parse(localStorage.getItem('currentUser'));
if (currentUser) {
  authstore.commit('auth_success', currentUser);
}

Vue.axios.defaults.headers.common.Authorization = "Bearer " + authstore.state.currentUser.token;
Vue.axios.interceptors.response.use(
  function (response) {
    return response;
  },
  function (error) {
    if (error.response && error.response.status && error.response.status == 401)
      authstore.dispatch("logout");
    return Promise.reject(error);
  });

  Vue.mixin({
      methods: {
        getUserNameLabel: function () {
          var user = JSON.parse(localStorage.getItem("currentUser"));
          if (user != null)
          try {
            return user.employeeFirstName + " " + user.employeeLastName;
          } catch (e) {
            console.log(e);
          }
          return '';
        }
      }
  });

new Vue({
  router,
  el: '#app',
  store,
  authstore,
  render: h => h(App),
  data: {
    showModal: false
  }
});

router.beforeEach((to, from, next) => {
  document.title = to.meta.title
  if (to.name != 'LoginPage') {
    if (authstore.state.currentUser) {
      if (!to.meta.roles) {
        return next();
      }
      if (authstore.state.currentUser.role.some(x => to.meta.roles.includes(x))) {
        return next();
      }
      else {
        return next(from.path);
      }
    }
    else {
      return next({ name: 'LoginPage' })
    }
  }
  else {
    next()
  }
})


