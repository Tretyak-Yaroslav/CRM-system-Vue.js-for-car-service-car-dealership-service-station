import { handleResponse, requestOptions } from '@/_helpers';

export const userService = {
    findStation
};

function findStation(name) {
    return fetch('http://localhost:49730/api/station/find?name=' + name, requestOptions.get())
        .then(response => {
            return response;
        });
}
