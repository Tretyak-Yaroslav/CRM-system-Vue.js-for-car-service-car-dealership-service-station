import { handleResponse, requestOptions } from '@/_helpers';

export const userService = {
    findStation
};

function findStation(name) {
    return fetch('http://garage.eso.local/api​/Auth​/Login/find?name=' + name, requestOptions.get())
        .then(response => {
            return response;
        });
}
