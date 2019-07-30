<template>
  <b-container class="bv-example-row bv-example-row-flex-cols">
    <b-row align-v="center" align-h="center">
      <b-form @submit="onSubmit" @reset="onReset" v-if="show" class="mx-auto">
        <b-form-group id="CustomerPhoneNumber" label="Телефон:" label-for="phone">
          <b-form-input
            id="CustomerPhoneNumber"
            v-model="form.CustomerPhoneNumber"
            required
            placeholder="+3809605478377"
          ></b-form-input>
        </b-form-group>

        <b-form-group id="CustomerFullName" label="Ім'я:" label-for="name">
          <b-form-input
            id="CustomerFullName"
            v-model="form.CustomerFullName"
            required
            placeholder="Введіть ім'я"
          ></b-form-input>
        </b-form-group>

        <b-form-group id="vehicleBrandName" label="Марка:" label-for="vehicleBrandName">
          <b-form-select
            id="vehicleBrandName" 
            v-model="form.vehicleBrandName"
            :options="vehicleBrandNames"
            vehicleBrandName =1;
            required
          ></b-form-select>
        </b-form-group>
        <b-form-group id="vehicleModelName" label="Модель:" label-for="vehicleModelName">
          <b-form-select
            id="vehicleModelName"
            v-model="form.vehicleModelName"
            :options="vehicleModelNames"
          ></b-form-select>
        </b-form-group>
        <b-form-group id="VehicleRegistrationNumber" label="Номер автомобіля:" label-for="number">
          <b-form-input
            id="VehicleRegistrationNumber"
            v-model="form.VehicleRegistrationNumber"
            required
            placeholder="Введіть номер автомобіля"
          ></b-form-input>
        </b-form-group>

        <b-form-group id="serviseName" label="Послуга:" label-for="serviseName">
          <b-form-select
            id="serviseName"
            v-model="form.serviseName"
            :options="serviseName"
            required
          ></b-form-select>
        </b-form-group>
     <!--    <b-form-group  placeholder="Текст">
          <b-form-select
            id="orderDescription"
            v-model="form.message"
            :options="orderDescription"
            required
          ></b-form-select>
      </b-form-group> -->
    <b-form-textarea id="orderDescription" placeholder="Коментар">
      id="orderDescription"
      v-model="text"
      rows="3"
      max-rows="6"
    ></b-form-textarea>

        <pre class="mt-3 mb-0">{{ text }}</pre>
        <b-col md="12" >
          <b-button type="submit" variant="success">Cтворити заявку</b-button>
        </b-col>
      </b-form>
      <b-card class="mt-3" header="Form Data Result">
        <pre class="m-0">{{ form }}</pre>
      </b-card>
    </b-row>
  </b-container>
</template>


<script>
import axios from "axios";
    export default {
        created() {
            console.log(this.$store);
            this.$store.dispatch('getVendor', { params: { id: 0 } })
                .then(res => {
                    var vendorsData = JSON.parse(JSON.stringify(res.data))
                    this.vehicleBrandNames = vendorsData.map(function (i) {
                        return {
                            text: i["vehicleBrandName"],
                            value: i["vehicleBrandID"]
                        }
                    });
                })
                .catch(error => { });
        },
  data() {
    return {
      form: {
        CustomerPhoneNumber: "",
        CustomerFullName: "",
        vehicleModelName: "",
        VehicleRegistrationNumber: "",
        vehicleBrandName: "",
        serviseName: "",
        orderDescription: ""
      },
      mounted() {
        axios
          .get(
            "http://garage.eso.local/api/order/GetOrder?from=2019-01-01&to=2020-01-01&workShopID=1"
          )
          .then(response => (this.info = response));
      }, 
       vehicleModelNames: [
        { text: "", value: null },
         
       ],
        show: true,
      vehicleBrandNames: [],
      serviseName: [
        { text: "", value: null },
        "Замена прокладки ГБЦ ",
        "Ремонт стартера",
        "Чистка дроссельной заслонки",
        "Замена сальников",
        "Замена стартера",
        "Чистка впускного коллектора",
        "Замена термомуфты",
        "Замена помпы ",
        "Диагностика бензинового двигателя",
        "Промывка топливной системы",
        "Замена подушки двигателя"
      ]
    };
  },
  methods: {
    onSubmit(evt) {
        evt.preventDefault();
        
        //orderService.setShortOrder(1, this.CustomerFullName, this.CustomerPhoneNumber, 1, this.orderDescription, 1, 1);
        //alert(JSON.stringify(this.form));
    },
    onReset(evt) {
      evt.preventDefault();
      // Reset our form values
      this.form.CustomerFullName = "";
      this.form.CustomerPhoneNumber = "";
      this.form.vehicleModelName = "";
      this.form.vehicleRegistrationNumber = "";
      this.form.vehicleBrandName = null;
      this.form.serviseName = "";
      this.form.orderDescription = "";
      // Trick to reset/clear native browser form validation state
      this.show = false;
      this.$nextTick(() => {
        this.show = true;
      });
    }
  }
};
</script>
<style lang="scss" scoped>

form {
  padding: 15px;
  background-color: #fff;
  background-clip: padding-box;
  border: 1px solid #999;
  border: 1px solid rgba(0, 0, 0, 0.2);
  border-radius: 6px;
  -webkit-box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
  box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
  outline: 0;
}
@media screen and (max-width: 600px){
.form-group {
    margin-bottom: 0.3rem;
}
label {
    margin-bottom: 0.2rem;
}
.btn.btn-success {
 float: right; 
}
}

</style>
