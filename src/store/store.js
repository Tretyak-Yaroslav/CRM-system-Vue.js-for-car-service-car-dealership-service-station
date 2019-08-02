import Vuex from "vuex"
import Vue from "vue"
import Vapi from "vuex-rest-api"

Vue.use(Vuex)

const posts = new Vapi({
    baseURL: "http://garage.eso.local:80/api",
    state: {
        posts: []
    }
})

    .post({
        action: "getVendor",
        property: "vendor",
        path: ({ id }) => `/Catalogue/GetVendor?vendorID=${id}`
    })
    .post({
        action: "getVehicleModel",
        property: "vendorModels",
        path: ({ id }) => `/Catalogue/GetVehicleModel?vendorID=${id}`
    })
    .post({
        action: "getWorkPlace",
        property: "workPlaces",
        path: ({ id }) => `/Catalogue/GetWorkPlace?workPlaceID=${id}`
    })
    .post({
        action: "setShortOrder",
        property: "shortOrder",
        path: ({ workShopID,
            customerFullName,
            customerPhoneNumber,
            serviceID,
            orderDescription,
            vehicleModelID,
            vendorID }) =>
            `/Order/SetShortOrder?workShopID=${workShopID}&customerFullName=${customerFullName}
                &customerPhoneNumber=${customerPhoneNumber}&serviceID=${serviceID}&orderDescription=${orderDescription}
                &vehicleModelID=${vehicleModelID}&vendorID=${vendorID}`
    })
    .post({
        action: "getItem",
        property: "itemCategory",
        path: ({ id }) => `/Catalogue/GetItem?itemCategoryID=${id}`
    })
    .getStore()

export const store = new Vuex.Store(posts)