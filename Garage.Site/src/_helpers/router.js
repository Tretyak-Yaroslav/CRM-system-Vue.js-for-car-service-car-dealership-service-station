import Vue from 'vue';
import Router from 'vue-router';
import LoginPage from '@/login/LoginPage';
import ShortQueryForm from '@/UserFormPage/ShortQueryForm';
import Detailtable from '@/components/TableDetails/DetailsTable';
import Disposition from '@/components/Disposition/DispositionPage';
import OrderOutfit from '@/components/OrderOutfit/OrderOutfit';
 
Vue.use(Router);
export const router = new Router({
    mode: 'history',
    routes: [
        { 
            path: '/', 
            name: 'LoginPage',
            component: LoginPage 
        },
        { 
            path: '/outfit', 
            name: 'OrderOutfit',
            component: OrderOutfit
        },
    
        { 
            path: '/table', 
            name:'Detailtable',
            component: Detailtable,
            meta: {
                roles: ["Shop.Disposition"]
              }
        },
       
        { 
            path: '/shortQuery', 
            name:'shortQuery',
            component: ShortQueryForm
        },   
        {
            path: '/disposition',
            name:'disposition',
            component: Disposition,
            meta: {
                roles: ["Shop.Disposition"]
              }
        },
        { path: '*', redirect: '/' }
    ]
});
