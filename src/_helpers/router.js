import Vue from 'vue';
import Router from 'vue-router';
import { authenticationService } from '@/_services';
import LoginPage from '@/login/LoginPage';
import UserFormPage from '@/UserFormPage/UserForm';
import Detailtable from '@/TableDetails/DetailsTable';
import Disposition from '@/Disposition/DispositionPage';

Vue.use(Router);
export const router = new Router({
    mode: 'history',
    routes: [
        { 
            path: '/', 
            component: LoginPage 
        },
        { 
            path: '/table', 
            component: Detailtable, 
        },
       
        { 
            path: '/user', 
            component: UserFormPage, 
        },
        {
            path: '/disposition',
            component: Disposition,
        },
        { path: '*', redirect: '/' }
    ]
});
router.beforeEach((to, from, next) => {
    const { authorize } = to.meta;
    const currentUser = authenticationService.currentUserValue;

    if (authorize) {
        if (!currentUser) {
            return next({ path: '/login', query: { returnUrl: to.path } });
        }
    }
    next();
})