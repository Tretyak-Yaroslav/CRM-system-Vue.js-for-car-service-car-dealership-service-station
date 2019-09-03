import Vuex from 'vuex'
import Vue from 'vue'
import App from './App.vue'
import { router } from './_helpers'
import BootstrapVue from 'bootstrap-vue'
import { TablePlugin } from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import axios from 'axios'
import VueAxios from 'vue-axios'
import { store } from './store'
import 'vue-datetime/dist/vue-datetime.css'
import VueI18n from 'vue-i18n'
Vue.config.productionTip = false;
Vue.use(VueI18n)
Vue.use(VueAxios, axios)
Vue.use(Vuex)
Vue.use(TablePlugin)
Vue.use(BootstrapVue)
Vue.config.productionTip = false

//Vue.prototype.$http = Axios;
const currentUser = JSON.parse(localStorage.getItem('currentUser'));
//this.$store.currentUser = JSON.parse(localStorage.getItem('currentUser'));
if (currentUser) {
  //Vue.prototype.$http.
  axios.defaults.headers.common['Authorization'] = 'Bearer ' + currentUser.token
}

new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App),
  data: {
    showModal: false
  }
});
