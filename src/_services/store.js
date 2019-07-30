/* import Vapi from "vuex-rest-api"
const posts = new Vapi({
  baseURL: "http://garage.eso.local:80/api",
    state: {
      posts: []
    }
  })

  .get({
    action: "getOrders",
    property: "post",
    path: ({ id }) => `/posts/${id}`
  })

  .get({
    action: "listPosts",
    property: "posts",
    path: "/posts"
  })

  .post({
    action: "setShortOrder",
    property: "post",
    path: ({ id }) => `/posts/${id}`
  })
  
  .getStore()

export const store = new Vuex.Store(posts) */