import Vuex from "vuex"
import Vue from "vue"
import Vapi from "vuex-rest-api"

Vue.use(Vuex)

const posts = new Vapi({
    baseURL: "http://localhost:49730/api",
    state: {
        posts: []
    }
})
    .get({
        action: "getVendor",
        property: "vendor",
        path: ({ id }) => `/Catalogue/GetVendor?vendorID=${id}`
    })
    .get({
        action: "getVehicleModel",
        property: "vendorModels",
        path: ({ id }) => `/Catalogue/GetVehicleModel?vehicleBrandID=${id}`
    })
    .post({
        action: "getWorkPlace",
        property: "workPlaces",
        path: ({ id }) => `/Catalogue/GetWorkPlace?workPlaceID=${id}`
    })
    .getStore()

export const store = new Vuex.Store(posts)