<script>
export default {
  el: '#api',
  data() {
    return {
      info: null
    };
  },
  mounted() {
    axios
      .get('http://garage.eso.local/api/order/GetOrder?from=2019-01-01&to=2020-01-01&workShopID=1')
      .then(response => (this.info = response));
  }
}
</script>

<template>
   <div id="api">
  {{ info }}
</div> 
</template>
