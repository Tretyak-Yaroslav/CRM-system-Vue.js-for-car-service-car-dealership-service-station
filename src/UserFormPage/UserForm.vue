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
          required
        ></b-form-select>
      </b-form-group>
       <b-form-group id="vehicleModelName" label="Модель:" label-for="model">
        <b-form-select
          id="vehicleModelName"
          v-model="form.vehicleModelName"
          :options="model"
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

 <b-form-group id="serviseName" label="Послуга:" label-for="serviseName">
        <b-form-select
          id="serviseName"
          v-model="form.serviseName"
          :options="serviseName"
          required
        ></b-form-select>
      </b-form-group>
 <b-form-orderDescription id="orderDescription"  placeholder="Короткий опис роботи" >
   <b-form-select
      id="orderDescription"
      v-model="form.orderDescription"
          :options="orderDescription"
          required
      ></b-form-select>
    </b-form-orderDescription >

    <pre class="mt-3 mb-0 ">{{ text }}</pre>
      <b-col  md="8" offset-md="6">
              <b-button type="submit" variant="success">Cтворити заявку</b-button>
      </b-col>
    </b-form>
    <b-card class="mt-3" header="Form Data Result">
      <pre class="m-0">{{ form }}</pre>
    </b-card>
    </b-row>
 </b-container>

</template>
<style scoped>
form{
  padding: 15px;
  background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #999;
    border: 1px solid rgba(0,0,0,0.2);
    border-radius: 6px;
    -webkit-box-shadow: 0 3px 9px rgba(0,0,0,0.5);
    box-shadow: 0 3px 9px rgba(0,0,0,0.5);
    outline: 0;
}
</style>

<script>
  export default {
    data() {
      return {
        form: {
          CustomerPhoneNumber: '',
          CustomerFullName: '',
          vehicleModelName: '',
          VehicleRegistrationNumber: '',
          vehicleBrandName: null,
          serviseName:'',
          orderDescription :'',
        },
        vehicleBrandNames: [{ text: '', value: null }, 'Range Rover', 'Ravon', 'Acura', 'Alfa Romeo','Audi','BMW','Brilliance','Buick','BYD','Cadillac','Chery','Chevrolet','Citroen','Daewoo','Daihatsu','Fiat','Ford','Geely','GMC','Great Wall','Honda','Hummer','Hyundai','Infiniti','JAC','Jeep','Kia','Lancia','Land Rover','Lexus','Mazda','Mercedes-Benz','Mercury','MG','Mini','Mitsubishi','Nissan','Opel','Peugeot','Porsche','Renault','SEAT','Skoda','Smart','SsangYong','Subaru','Suzuki','Toyota','Vauxhall','Volkswagen','Volvo',],
        show: true,
        serviseName: [{ text: '', value: null }, 'Замена прокладки ГБЦ ','Ремонт стартера','Чистка дроссельной заслонки','Замена сальников','Замена стартера','Чистка впускного коллектора','Замена термомуфты','Замена помпы ','Диагностика бензинового двигателя','Промывка топливной системы','Замена подушки двигателя'],
        show: true
      }
    },
    methods: {
      onSubmit(evt) {
        evt.preventDefault()
        alert(JSON.stringify(this.form))
      },
      onReset(evt) {
        evt.preventDefault()
        // Reset our form values
        this.form.CustomerFullName = ''
        this.form.CustomerPhoneNumber = ''
        this.form.vehicleModelName = ''
        this.form.vehicleRegistrationNumber = ''
        this.form.vehicleBrandName = null
        this.form.serviseName = ''
        this.form.orderDescription=''
        // Trick to reset/clear native browser form validation state
        this.show = false
        this.$nextTick(() => {
          this.show = true
        })
      }
    }
  }
</script>