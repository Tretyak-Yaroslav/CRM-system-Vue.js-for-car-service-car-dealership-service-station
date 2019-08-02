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

        <b-form-group id="vendorName" label="Марка:" label-for="vendorName">
          <b-form-select
            id="vendorName"
            v-model="form.vendorName"
            :options="vendorNames"
            v-on:change="getSelectedBrand"
            required
          ></b-form-select>
        </b-form-group>
        <b-form-group id="vehicleModelName" label="Модель:" label-for="vehicleModelName">
          <b-form-select
            id="vehicleModelName"
            v-model="form.vehicleModelName"
            :options="vehicleModelNames"
             required
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

        <b-form-group id="itemCategoryID" label="Послуга:" label-for="itemCategoryID">
          <b-form-select
            id="itemCategoryID"
            v-model="form.itemCategoryID"
            :options="itemCategoryIDs"
            required
          ></b-form-select>
        </b-form-group>

        <b-form-textarea
          id="orderDescription"
          v-model="form.orderDescription"
          placeholder="Коментар"
          rows="2"
          max-rows="2"
         
        ></b-form-textarea>

        <!--<pre class="mt-3 mb-0">{{ text }}</pre>-->
        <b-col md="12">
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
export default {
  created() {
    this.$store.dispatch("getVendor", { params: { id: 0 } }).then(res => {
      var vendorsData = JSON.parse(JSON.stringify(res.data));
      this.vendorNames = vendorsData.map(function(i) {
        return {
          text: i["vendorName"],
          value: i["vendorID"]
        };
      });
    });
  },
  
  data() {
    return {
      form: {
        CustomerPhoneNumber: "",
        CustomerFullName: "",
        vehicleModelName: "",
        VehicleRegistrationNumber: "",
        vendorName: "",
        itemCategoryID: "",
        orderDescription: ""
      },

      vehicleModelNames: [],
      show: true,
      vendorNames: [],
      itemCategoryIDs: [],
    };
  },

  methods: {
    onSubmit(evt) {
      evt.preventDefault();
      this.$store
        .dispatch("setShortOrder", {
          params: {
            workShopID: 1,
            customerFullName: this.form.CustomerFullName,
            customerPhoneNumber: this.form.CustomerPhoneNumber,
            serviceID: 1,
            orderDescription: this.form.orderDescription,
            vehicleModelID: this.form.vehicleModelName,
            vendorID: this.form.vendorName
          }
        })
        .then(response => {
          alert(`Заявка № ${response.data} відправлена`);
        })
        .catch(response => {
          alert("Error: " + response.message);
        });
      this.clearForm();
    },
    onReset(evt) {
      evt.preventDefault();
      // Reset our form values
      clearForm();
      // Trick to reset/clear native browser form validation state
      this.show = false;
      this.$nextTick(() => {
        this.show = true;
      });
    },

    clearForm() {
      this.form.CustomerFullName = "";
      this.form.CustomerPhoneNumber = "";
      this.form.vehicleModelName = "";
      this.form.vehicleRegistrationNumber = "";
      this.form.vendorName = "";
      this.form.itemCategoryID = "";
      this.form.orderDescription = "";
      this.form.VehicleRegistrationNumber = "";
    },
    getSelectedBrand(id) {
      console.log(id);

      this.$store
        .dispatch("getVehicleModel", { params: { id: id } })
        .then(res => {
          var vendorsData = JSON.parse(JSON.stringify(res.data));
          this.vehicleModelNames = vendorsData.map(function(i) {
            return {
              text: i["vehicleModelName"],
              value: i["vehicleModelID"]
            };
          });
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
textarea #orderDescription{
    overflow-y: auto;
}
@media screen and (max-width: 600px) {
  .form-group {
    margin-bottom: 0.3rem;
  }

  label {
    margin-bottom: 0.2rem;
  }
}
.btn.btn-success[data-v-44a775b7] {
  float: right;
  margin-top: 10px;
}
</style>
