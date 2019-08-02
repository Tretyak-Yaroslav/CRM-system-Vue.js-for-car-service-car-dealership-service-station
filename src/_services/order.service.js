/* import { BehaviorSubject } from 'rxjs';
import { requestOptions, handleResponse } from '@/_helpers';

export const orderService = {
    getOrders,
    setShortOrder
};

function getOrders(from, to, workShopID, shortOrder) {
    return fetch('http://garage.eso.local/api/order/getOrder?from=' + from + '&to=' + to + '&workShopID=' + workShopID + '&shortOrder=' + shortOrder, requestOptions.get())
        .then(response => {
            return response;
        });
};


function setShortOrder(workShopID, customerFullName, customerPhoneNumber, itemCategoryID, orderDescription, vehicleModelID, vendorID) {
    return fetch('http://garage.eso.local/api/order/setShortOrder', requestOptions.post({
            workShopID, customerFullName, customerPhoneNumber, itemCategoryID, orderDescription, vehicleModelID, vendorID
        }))
        .then(handleResponse)
        .then(response => {
            return response;
        });
}
 */