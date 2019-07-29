import Vapi from "vuex-rest-api"
export const orderService = {
  getOrders,
  setShortOrder
};
export default {
    get baseApiUrl() {
        switch (window.location.hostname.toLowerCase()) {
            case "localhost":
                return "http://garage.eso.local:80/api";
            case "garage.eso.local":
                return "https://garage.eso.local/api";
        }
    },
    get baseUrl() {
        switch (window.location.hostname.toLowerCase()) {
            case "localhost":
                return "http://garage.eso.local/";
            case "garage.eso.local":
                return "https://garage.eso.local";
        }
    },
};
const posts = new Vapi({
    baseURL: "http://garage.eso.local",
      state: {
        posts: []
      }
    })
    .get({
        action: "getPost",
        property: "post",
        path: ({ id }) => `/posts/${id}`
      })
      .get({
        action: "listPosts",
        property: "posts",
        path: "/posts"
      })
      .post({
        action: "updatePost",
        property: "post",
        path: ({ id }) => `/posts/${id}`
      })
      .getStore()
    export const store = new Vuex.Store(posts)


    function getOrders(from, to, workShopID, shortOrder) {
      return fetch( + from + '&to=' + to + '&workShopID=' + workShopID + '&shortOrder=' + shortOrder, requestOptions.get())
          .then(response => {
              return response;
          });
  };
  function setShortOrder(workShopID, customerFullName, customerPhoneNumber, serviceID, orderDescription, vehicleModelID, vehicleBrandID) {
    return fetch( requestOptions.post({
            workShopID, customerFullName, customerPhoneNumber, serviceID, orderDescription, vehicleModelID, vehicleBrandID
        }))
        .then(handleResponse)
        .then(response => {
            return response;
        });
}