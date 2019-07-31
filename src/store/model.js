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

.get({
    action: "GetVehicleModel",
    property: "model",
    path: ({ id }) => `/Catalogue/GetVehicleModel?vehicleBrandID=${id}`
})
.get({
    action: "GetVehicleModel",
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