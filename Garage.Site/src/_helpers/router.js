import Vue from 'vue';
import Router from 'vue-router';
import { store } from '@/store';
import LoginPage from '@/login/LoginPage';
import ShortQueryForm from '@/UserFormPage/ShortQueryForm';
import Detailtable from '@/TableDetails/DetailsTable';
import Disposition from '@/disposition/DispositionPage';
import ModalForm from '@/ModalFormDisposition/ModalForm';





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
            path: '/table', 
            name:'Detailtable',
            component: Detailtable,
            meta: {
                roles: ["Shop.Disposition"]
              }
        },
        { 
            path: '/modal', 
            component: ModalForm, 
            meta: {
                roles: ["Shop.Disposition"]
              }
        },
       
        { 
            path: '/shortQuery', 
            name:'shortQuery',
            component: ShortQueryForm
            //, 
            // meta: {
            //     roles: ["User", "Admin"]
            //   }

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
// router.beforeEach((to, from, next) => {
//     if(to.name !='LoginPage')
//     {
//         const currentUser = JSON.parse(localStorage.getItem('currentUser'));
//         var IsAccess = false;
//         if (currentUser) {
//             if (!to.meta.roles) {
//                     return next()
//             }           
//             currentUser.role.forEach(function(element)
//             {                
//                 if (to.meta.roles.includes(element)) {
//                     IsAccess  = true;
//                     return next();
//                 }
//             });
//             if(IsAccess){
//                 return next();
//             }
//             else{
//                 next(from.path);
//             }
//         }
//         else {
//             return next({name: 'LoginPage'})
//         }
//     }
//     else{
//         next()
//     }
//     //next(from.path)
// })