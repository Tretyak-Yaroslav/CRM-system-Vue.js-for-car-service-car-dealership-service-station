import Vuex from "vuex"
import Vue from "vue"
import Vapi from "vuex-rest-api"

import axios from 'axios'; 

Vue.use(Vuex)

export const authstore = new Vuex.Store({
        state:{
            status: '',
                currentUser: JSON.parse(localStorage.getItem('currentUser'))            
                // {
                //     token: null,
                //     userName: '',
                //     workShopID: 0,
                //     EmployeeID: 0,
                //     employeeFirstName: '',
                //     employeeLastName: '',
                //     role: []
                // }
            },
        mutations: {
            auth_request(state){
                state.status = 'loading'
              },
              auth_success(state, currentUser){
                state.status = 'success'
                state.currentUser = currentUser;
                //state.user = user
              },
              auth_error(state){
                state.status = 'error'
              },
              logout(state){
                state.status = ''
                state.currentUser = null;
                // state.currentUser.token = null;
                // state.currentUser.userName = '';
                // state.currentUser.workShopID = 0;
                // state.currentUser.EmployeeID = 0;
                // state.currentUser.employeeFirstName = '';
                // state.currentUser.employeeLastName = '';
                // state.currentUser.role = [];
              }
        },
        actions: {
            logout({commit}){
                return new Promise((resolve, reject) => {
                  commit('logout')
                  localStorage.removeItem('currentUser');
                  delete axios.defaults.headers.common['Authorization']
                  resolve()
                })
               }
        },
        getters : {
            isLoggedIn: state => !!state.currentUser,
            authStatus: state => state.status
        },
})


const posts = new Vapi({
        baseURL: "http://garage.eso.local:80/api",
        //baseURL: "https://localhost:44346/api",
        state:{
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
        action: "postOrder",
        property: "shortorder",
        path: ({ from, to, workShopID, orderStatusID, notShortOrder }) => `Order/PostOrder?from=${from}&to=${to}&workShopID=
        ${workShopID}&orderStatusID=${orderStatusID}&notShortOrder=${notShortOrder}`
                                            
    })
    .post({
        action: "setShortOrder",
        property: "shortOrder",
        path: ({ workShopID,
            customerFullName,
            customerPhoneNumber,
            itemID,
            orderDescription,
            vehicleModelID,
            vendorID,
            vehicleRegistrationNumber }) =>
            `/Order/SetShortOrder?workShopID=${workShopID}&customerFullName=${customerFullName}
                &customerPhoneNumber=${customerPhoneNumber}&itemID=${itemID}&orderDescription=${orderDescription}
                &vehicleModelID=${vehicleModelID}&vendorID=${vendorID}&vehicleRegistrationNumber=${vehicleRegistrationNumber}`
    })
    .post({
        action: "getOrderStatus",
        property: "requestStatus",
        path: ({ id }) => `/Catalogue/GetOrderStatus?OrderStatusID=${id}`
    })
    .post({
        action: "getVendor",
        property: "vendor",
        path: ({ id }) => `/Catalogue/GetVendor?vendorID=${id}`
    })
    .post({
        action: "getItem",
        property: "itemCategory",
        path: ({ id }) => `/Catalogue/GetItem?itemCategoryID=${id}`
    })
    .get({
        action:"getOrder",
        property:"getOrdertable",
        path:({from , to, workShopID, orderStatusID, notShortOrder}) =>`/Order/GetOrder?from=${from}&to=${to}&workShopID=
            ${workShopID}&orderStatusID=${orderStatusID}
            &notShortOrder=${notShortOrder}`})
    
    
    .post({
        action: "setOrder",
        property: "setOrder",
        path: ({ orderID,
            workShopID,
            customerFullName,
            customerPhoneNumber,
            itemID,
            orderDescription,
            vehicleModelID,
            vehicleModificationID,
            vehicleRegistrationNumber,
            employeeID,
            employeeCreateOrderID,
            workPlaceID,
            startTime,
            endTime,
            orderStatusID }) => `/Order/SetOrder?orderID=${orderID}
        &workShopID=${workShopID}&customerFullName=${customerFullName}
        &customerPhoneNumber=${customerPhoneNumber}&itemID=${itemID}
        &orderDescription=${orderDescription}&vehicleModelID=${vehicleModelID}
        &vehicleModificationID=${vehicleModificationID}&vehicleRegistrationNumber=${vehicleRegistrationNumber}
        &employeeID=${employeeID}&employeeCreateOrderID=${employeeCreateOrderID}
        &workPlaceID=${workPlaceID}&startTime=${startTime}&endTime=${endTime}
        &orderStatusID=${orderStatusID}`
    })
    .post({
        action: "Login",
        property: "EmployeeUser",
        path: ({ workShopID,employeeLogin,employeePwd }) => `/Auth/Login?workShopID=${workShopID}&employeeLogin=${employeeLogin}&employeePwd=${employeePwd}`
    })
  /*   .get({
        action:"getOrderOne",
        property:"getOrderOne",
        path:({from , to, workShopID, orderStatusID, notShortOrder, orderID}) =>`/Order/GetOrder?from=${from}&to=${to}&workShopID=
            ${workShopID}&orderStatusID=${orderStatusID}
            &notShortOrder=${notShortOrder}&orderID=${orderID}`}) */

    .post({
        action: "postOrder",
        property: "shortorder",
        path: ({ from, to, workShopID, orderStatusID, notShortOrder, orderID }) => `Order/PostOrder?from=${from}&to=${to}&workShopID=
        ${workShopID}&orderStatusID=${orderStatusID}&notShortOrder=${notShortOrder} &orderID=${orderID}`                                         
        })        
    .getStore()


export const store = new Vuex.Store(posts)