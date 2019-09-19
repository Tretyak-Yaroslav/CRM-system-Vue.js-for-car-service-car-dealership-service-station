import { BehaviorSubject, from } from 'rxjs';
import { requestOptions, handleResponse } from '@/_helpers';
import { } from '@/_services'
function login(username, password) {
    return fetch(`http://garage.eso.local/api​/Auth​/Login`, requestOptions.post({ username, password }))
        .then(handleResponse)
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
