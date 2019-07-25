import Vue from 'vue'
import App from './App.vue'
import { router } from './_helpers'
import BootstrapVue from 'bootstrap-vue'
import { TablePlugin } from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'

Vue.use(TablePlugin)
Vue.use(BootstrapVue)
Vue.config.productionTip = false

new Vue({
    el: '#app',
    router,
    render: h => h(App),
    data: {
        showModal: false
      }
});
