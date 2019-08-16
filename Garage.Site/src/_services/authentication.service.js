import { BehaviorSubject, from } from 'rxjs';

import { requestOptions, handleResponse } from '@/_helpers';

import {  } from '@/_services'

// const currentUserSubject = new BehaviorSubject(JSON.parse(localStorage.getItem('currentUser')));

//<<<<<<< HEAD
// export const authenticationService = {
//     login,
//     logout,
//     currentUser: currentUserSubject.asObservable(),
//     get currentUserValue () { return currentUserSubject.value }
// };
//  function login1(workShopID ,employeeLogin, employeePwd ) {
//     return fetch(`https://localhost:44346/api/Auth/Login?`, requestOptions.post({workShopID, employeeLogin, employeePwd }))
//        .then(handleResponse)
//        .then(response => {
//            if (response.ok) {
//                localStorage.setItem('currentUser', JSON.stringify(response));
//                currentUserSubject.next(response);
//                return response;
//            } else {
//                return new error();
//            }
//        });
// }

function login(username, password) {
    return fetch(`http://garage.eso.local/api​/Auth​/Login`, requestOptions.post({ username, password }))
        .then(handleResponse)
//>>>>>>> 0e0e15d81e933c6e8aeabf0ffdf0ebf94863045a
       .then(response => {
           if (response.ok) {
               localStorage.setItem('currentUser', JSON.stringify(response));
               currentUserSubject.next(response);
               return response;
           } else {
               return new error();
           }
       });
}

function logout() {
    localStorage.removeItem('currentUser');
    currentUserSubject.next(null);
}
