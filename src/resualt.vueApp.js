const url = "http://garage.eso.local/api/order/GetOrder?from=2019-01-01&to=2020-01-01&workShopID=1";
const vm = new Vue({
  el: '#app',
  data: {
    results: []
  },
  mounted() {
    axios.get(url).then(response => {
      this.results = response.data
    })
  }
});