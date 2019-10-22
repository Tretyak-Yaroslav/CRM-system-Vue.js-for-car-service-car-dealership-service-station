import Vuex from "vuex";
import Vue from "vue";
import Vapi from "vuex-rest-api";
import { router } from "../_helpers";
import axios from "axios";

Vue.use(Vuex);

export const authstore = new Vuex.Store({
  state: {
    status: "",
    currentUser: {
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
      state.status = "loading";
    },
    auth_success(state, currentUser) {
      state.status = "success";
      //state.currentUser = currentUser;
      state.currentUser.token = currentUser.token;
      state.currentUser.userName = currentUser.userName;
      state.currentUser.workShopID = currentUser.workShopID;
      state.currentUser.EmployeeID = currentUser.EmployeeID;
      state.currentUser.employeeFirstName = currentUser.employeeFirstName;
      state.currentUser.employeeLastName = currentUser.employeeLastName;
      state.currentUser.role = currentUser.role;
      state.currentUser.isAuth = true;
      //state.user = user
    },
    auth_error(state) {
      state.status = "error";
    },
    logout(state) {
      state.status = "";
      state.currentUser.token = "";
      state.currentUser.userName = "";
      state.currentUser.workShopID = "";
      state.currentUser.EmployeeID = "";
      state.currentUser.employeeFirstName = "";
      state.currentUser.employeeLastName = "";
      state.currentUser.role = [];
      state.currentUser.isAuth = false;

      router.push("/");
    }
  },
  actions: {
    logout({ commit }) {
      return new Promise((resolve, reject) => {
        commit("logout");
        localStorage.removeItem("currentUser");
        delete axios.defaults.headers.common["Authorization"];
        resolve();
      });
    }
  },
  getters: {
    isLoggedIn: state => !!state.currentUser.isAuth,
    authStatus: state => state.status
  }
});
const posts = new Vapi({

    baseURL: process.env.VUE_APP_API,
 // baseURL: "http://garage.eso.local:80/api",
 // baseURL: "https://api.autodata-group.com/docs",



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
    path: ({ workShopID, employeePostID }) =>
      `/Catalogue/GetEmployees?workShopID=${workShopID}&employeePostID=${employeePostID}`
  })
  .post({
    action: "postQuery",
    property: "shortquery",
    path: ({
      from,
      to,
      workShopID,
      queryStatusID,
      notShortQuery
    }) => `Order/PostQuery?from=${from}&to=${to}&workShopID=
        ${workShopID}&queryStatusID=${queryStatusID}&notShortQuery=${notShortQuery}`
  })
  .post({
    action: "setShortQuery",
    property: "shortQuery",
    path: ({
      workShopID,
      customerFullName,
      customerPhoneNumber,
      itemID,
      queryDescription,
      vehicleModelID,
      vendorID,
      vehicleRegistrationNumber,
      QueryStatusID
    }) =>
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
    path: ({ id, isVisible }) =>
      `/Catalogue/GetVendor?vendorID=${id}&isVisible=${isVisible}`
  })
  .post({
    action: "getCustomer",
    property: "customer",
    path: ({ id, searchChars}) => `/Catalogue/GetCustomer?ID=${id}&searchChars=${!searchChars ? '': searchChars}` 
})
.post({
    action: "getCustomersByVehicle",
    property: "customersVehicle",
    path: ({ vehicleID}) => `/Catalogue/GetCustomersByVehicle?vehicleID=${vehicleID}` 
})
.post({
    action: "getVehiclesByCustomer",
    property: "vehicleCustomers",
    path: ({ customerID}) => `/Catalogue/GetVehiclesByCustomer?customerID=${customerID}` 
})
.post({
    action: "setCustomer",
    property: "setCustomer",
    path: "/Order/SetCustomer"
})
.post({
    action: "getVehicle",
    property: "vehicle",
    path: ({ id, searchChars}) => `/Catalogue/GetVehicle?ID=${id}&searchChars=${!searchChars ? '': searchChars}` 
})
.post({
    action: "setVehicle",
    property: "setVehicle",
    path: "/Order/SetVehicle"
})
  .post({
    action: "getItem",
    property: "itemCategory",
    path: ({ id }) => `/Catalogue/GetItem?itemCategoryID=${id}`
  })
  .get({
    action: "getQuery",
    property: "query",
    path: ({ from, to, workShopID, statusID, notShortQuery, ID }) => `/Order/GetQuery?from=${from}&to=${to}&workShopID=${workShopID}&statusID=${statusID}&notShortQuery=${notShortQuery}&ID=${ID}`
})
  .post({
    action: "setQuery",
    property: "setQuery",
    path: "/Order/SetQuery" })
  .post({
    action: "Login",
    property: "EmployeeUser",
    path: ({ workShopID, employeeLogin, employeePwd }) =>
      `/Auth/Login?workShopID=${workShopID}&employeeLogin=${employeeLogin}&employeePwd=${employeePwd}`
  })

  .post({
    action: "postQuery",
    property: "shortquery",
    path: ({
      from,
      to,
      workShopID,
      queryStatusID,
      notShortQuery,
      queryID
    }) => `Order/PostQuery?from=${from}&to=${to}&workShopID=
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
    path: ({
      from,
      to,
      workShopID,
      statusID,
      notShortQuery,
      id
    }) => `/Order/ExportQueryToFile?from=${from}&to=${to}&workShopID=
            ${workShopID}&statusID=${statusID}&notShortQuery=${notShortQuery}&id=${id}`
  })

  /* Autodata */
  .get({
    action: "v1/manufacturers",
    property: "SearchByCountry",
    path: ({ countrycode, page, limit, api_key }) =>
      `/v1/manufacturers?country-code=${countrycode}&page=${page}&limit=${limit}&api_key=${api_key}`
  })
  .get({
    action: "v1/vehicle-identifiers/vins/:vin-id",
    property: "VinDecoder",
    path: ({ vinID, countryCodeVin, api_key }) =>
      `/v1/vehicle-identifiers/vins/&vinID=${vinID}?&countryCodeVin=${countryCodeVin}&api_key=${api_key}`
  })
  .get({
    action: "v1/manufacturers/:manufacturer_id",
    property: " SearchModels",
    path: ({ id }) => `v1/manufacturers&manufacturer_id=${id}`
  })
  .get({
      action:"v1/Vehicles/:Mid/Common-Service-Operations/:service_schedule_id",
      property: "ServiceSchedule",
      path: ({ acceptlanguage, api_key, countrycode}) =>
          `v1/vehicles/AUD00528/common-service-operations/AUDSG0000082?&country-code=${countrycode}&api_key=${api_key}&Accept-Language=${acceptlanguage}`
  })
  .getStore();

export const store = new Vuex.Store(posts);
