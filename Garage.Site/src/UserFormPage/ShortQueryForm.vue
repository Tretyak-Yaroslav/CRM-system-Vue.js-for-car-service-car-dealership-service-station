<template>
<ShortQueryForm>
  <b-container class="bv-example-row bv-example-row-flex-cols">
    <b-row align-v="center" align-h="center">
      <b-form @submit="onSubmit" @reset="onReset" v-if="show" class="mx-auto">

      <b-form-group id="CustomerPhoneNumber" label="Телефон:" label-for="phone">
            <masked-input
              v-model="form.CustomerPhoneNumber"
              id="CustomerPhoneNumber"
              required
              type="text"
              name="phone"
              class="form-control"
               mask="\+\38 (111) 111-1111"
            />
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
        <b-form-group id="vehicleRegistrationNumber" label="Номер автомобіля:" label-for="vehicleRegistrationNumber">
          <b-form-input
            id="vehicleRegistrationNumber"
            v-model="form.vehicleRegistrationNumber"
            required
            placeholder="Введіть номер автомобіля"
          ></b-form-input>
        </b-form-group>

        <b-form-group id="itemCategory" label="Послуга:" label-for="itemCategory">
          <b-form-select
            id="itemCategory"
            v-model="form.itemCategory"
            :options="itemCategorys"
            required
          ></b-form-select>
        </b-form-group>

        <b-form-textarea
          id="queryDescription"
          v-model="form.queryDescription"
          placeholder="Коментар"
          rows="2"
          max-rows="2"
         
        ></b-form-textarea>

        <!--<pre class="mt-3 mb-0">{{ text }}</pre>-->
        <b-col md="12">
          <b-button type="submit" variant="success">Cтворити заявку</b-button>
        </b-col>
      </b-form>
      <b-card class="mt-3 visibility" header="Form Data Result" >
        <pre class="m-0"  >{{ form  }}</pre>
      </b-card>
    <!--   <button @click="goTotable">goTotable</button> -->
    </b-row>
  </b-container>
  </ShortQueryForm>
</template>


<script>
import MaskedInput from "vue-text-mask";
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
      this.$store.dispatch("getItem", { params: { id: 0 } }).then(res => {
      var vendorsData = JSON.parse(JSON.stringify(res.data));
      this.itemCategorys = vendorsData.map(function(i) {
        return {
          text: i["itemName"],
          value: i["itemID"]
        };
      });
    });
  },
  data() {
    return {
      form: {
        CustomerPhoneNumber: "",
        CustomerPhoneNumber: "",
        CustomerFullName: "",
        vehicleModelName: "",
        vehicleRegistrationNumber: "",
        vendorName: "",
        queryDescription: ""
      },
      vehicleModelNames: [],
      show: true,
      vendorNames: [],
      itemCategorys: [],
    };
  },
components: {
    MaskedInput
  },
  methods: {
    onSubmit(evt) {
      evt.preventDefault();
      this.$store
        .dispatch("setShortQuery", {
          params: {
            workShopID: 1,
            customerFullName: this.form.CustomerFullName,
            customerPhoneNumber: this.form.CustomerPhoneNumber,
            /* serviceID: 1, */
            QueryStatusID:1,
            queryDescription: this.form.queryDescription,
            vehicleModelID: this.form.vehicleModelName,
            itemID: this.form.itemCategory,
            vendorID: this.form.vendorName,
            vehicleRegistrationNumber: this.form.vehicleRegistrationNumber
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
    goTotable() {
    this.$router.push({name:'Detailtable'}) //navigate to the page table
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
      this.form.queryDescription = "";
    },
    getSelectedBrand(id) {
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
.container {
    max-width: 550px;
}
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
textarea #queryDescription{
    overflow-y: auto;
}
.btn-success {
    float: right;
    margin-top: 10px;
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
.visibility{
  display: none;
}
</style>
