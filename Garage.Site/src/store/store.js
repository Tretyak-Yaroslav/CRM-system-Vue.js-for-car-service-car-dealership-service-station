import Vuex from "vuex"
import Vue from "vue"
import Vapi from "vuex-rest-api"
import { router } from '../_helpers'
import axios from 'axios';

Vue.use(Vuex)

export const authstore = new Vuex.Store({
    state: {
        status: '',
        currentUser:
        {
            token: "",
            userName: "",
            workShopID: "",
            EmployeeID: "",
            employeeFirstName: "",
            employeeLastName: "",
            role: [],
            isAuth: false
        }
        //JSON.parse(localStorage.getItem('currentUser'))                          
    },
    mutations: {
        auth_request(state) {
            state.status = 'loading'
        },
        auth_success(state, currentUser) {
            state.status = 'success'
            //state.currentUser = currentUser;
            state.currentUser.token = currentUser.token
            state.currentUser.userName = currentUser.userName
            state.currentUser.workShopID = currentUser.workShopID
            state.currentUser.EmployeeID = currentUser.EmployeeID
            state.currentUser.employeeFirstName = currentUser.employeeFirstName
            state.currentUser.employeeLastName = currentUser.employeeLastName
            state.currentUser.role = currentUser.role
            state.currentUser.isAuth = true
            //state.user = user

        },
        auth_error(state) {
            state.status = 'error'
        },
        logout(state) {
            state.status = ''
            state.currentUser.token = ""
            state.currentUser.userName = ""
            state.currentUser.workShopID = ""
            state.currentUser.EmployeeID = ""
            state.currentUser.employeeFirstName = ""
            state.currentUser.employeeLastName = ""
            state.currentUser.role = []
            state.currentUser.isAuth = false

            router.push("/");
        }
    },
    actions: {
        logout({ commit }) {
            return new Promise((resolve, reject) => {
                commit('logout')
                localStorage.removeItem('currentUser');
                delete axios.defaults.headers.common['Authorization']
                resolve()
            })
        }
    },
    getters: {
        isLoggedIn: state => !!state.currentUser.isAuth,
        authStatus: state => state.status
    },
})
const posts = new Vapi({
     baseURL: "http://garage.eso.local:80/api",
   // baseURL: "https://localhost:44346/api",
    state: {
        posts: []
    }
})
    .post({
        action: "getVehicleModel",
        property: "vendorModels",
        path: ({ id }) => `/Catalogue/GetVehicleModel?vendorID=${id}`
    })

    .post({
        action: "getWorkPlace",
        property: "workPlaces",
        path: ({ id }) => `/Catalogue/GetWorkPlace?workShopeID=${id}`
    })

    .post({
        action: "getEmployees",
        property: "resources",
        path: ({ workShopID, employeePostID }) => `/Catalogue/GetEmployees?workShopID=${workShopID}&employeePostID=${employeePostID}`

    })
    .post({
        action: "postQuery",
        property: "shortquery",
        path: ({ from, to, workShopID, queryStatusID, notShortQuery }) => `Order/PostQuery?from=${from}&to=${to}&workShopID=
        ${workShopID}&queryStatusID=${queryStatusID}&notShortQuery=${notShortQuery}`

    })
    .post({
        action: "setShortQuery",
        property: "shortQuery",
        path: ({ workShopID,
            customerFullName,
            customerPhoneNumber,
            itemID,
            queryDescription,
            vehicleModelID,
            vendorID,
            vehicleRegistrationNumber, QueryStatusID }) =>
            `/Order/SetShortQuery?workShopID=${workShopID}&customerFullName=${customerFullName}
                &customerPhoneNumber=${customerPhoneNumber}&itemID=${itemID}&queryDescription=${queryDescription}
                &vehicleModelID=${vehicleModelID}&vendorID=${vendorID}&vehicleRegistrationNumber=${vehicleRegistrationNumber}&QueryStatusID=${QueryStatusID}`
    })
    .post({
        action: "getQueryStatus",
        property: "requestStatus",
        path: ({ id }) => `/Catalogue/GetQueryStatus?QueryStatusID=${id}`
    })
    .post({
        action: "getVendor",
        property: "vendor",
        path: ({ id, isVisible}) => `/Catalogue/GetVendor?vendorID=${id}&isVisible=${isVisible}`
    })
    .post({
        action: "getItem",
        property: "itemCategory",
        path: ({ id }) => `/Catalogue/GetItem?itemCategoryID=${id}`
    })
    .get({
        action: "getQuery",
        property: "getQuerytable",
        path: ({ from, to, workShopID, queryStatusID, notShortQuery }) => `/Order/GetQuery?from=${from}&to=${to}&workShopID=
            ${workShopID}&queryStatusID=${queryStatusID}
            &notShortQuery=${notShortQuery}`
    })
    .post({
        action: "setQuery",
        property: "setQuery",
        path: ({ queryID,
            workShopID,
            customerFullName,
            customerPhoneNumber,
            itemID,
            queryDescription,
            vehicleModelID,
            vehicleModificationID,
            vehicleRegistrationNumber,
            employeeID,
            employeeMasterID,
            workPlaceID,
            startTime,
            endTime,
            queryStatusID,
            vehicleID,
            customerID,
            isDeleted}) => `/Order/SetQuery?queryID=${queryID}
        &workShopID=${workShopID}&customerFullName=${customerFullName}
        &customerPhoneNumber=${customerPhoneNumber}&itemID=${itemID}
        &queryDescription=${queryDescription}&vehicleModelID=${vehicleModelID}
        &vehicleModificationID=${vehicleModificationID}&vehicleRegistrationNumber=${vehicleRegistrationNumber}
        &employeeID=${employeeID}&employeeMasterID=${employeeMasterID}
        &workPlaceID=${workPlaceID}&startTime=${startTime}&endTime=${endTime}
        &queryStatusID=${queryStatusID}&vehicleID=${vehicleID}
        &customerID=${customerID}&isDeleted=${isDeleted}`
    })
    .post({
        action: "Login",
        property: "EmployeeUser",
        path: ({ workShopID, employeeLogin, employeePwd }) => `/Auth/Login?workShopID=${workShopID}&employeeLogin=${employeeLogin}&employeePwd=${employeePwd}`
    })

    .post({
        action: "postQuery",
        property: "shortquery",
        path: ({ from, to, workShopID, queryStatusID, notShortQuery, queryID }) => `Order/PostQuery?from=${from}&to=${to}&workShopID=
        ${workShopID}&queryStatusID=${queryStatusID}&notShortQuery=${notShortQuery} &queryID=${queryID}`
    })
    .post({
        action: "GeneratePassword",
        property: "Email",
        path: ({ email }) => `/Auth/GeneratePassword?email=${email}`
    })
    .post({
        action: "ExportQueryToFile",
        property: "ExportQueryToFile",
        path: ({ from, to, workShopID, queryStatusID, notShortQuery, queryID }) => `/Order/ExportQueryToFile?from=${from}&to=${to}&workShopID=
            ${workShopID}&queryStatusID=${queryStatusID}&notShortQuery=${notShortQuery}&queryID=${queryID}`
    })
    .getStore()


export const store = new Vuex.Store(posts)