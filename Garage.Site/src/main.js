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
import Datetime from 'vue-datetime'
import 'vue-datetime/dist/vue-datetime.css'
import VueI18n from 'vue-i18n'

Vue.use(VueI18n)
Vue.use(Datetime)
Vue.use(VueAxios, axios)
Vue.use(Vuex)
Vue.use(TablePlugin)
Vue.use(BootstrapVue)
Vue.config.productionTip = false

new Vue({
  el: '#app',
    router,
  store,
  render: h => h(App),
  data: {
    showModal: false
  }
});
