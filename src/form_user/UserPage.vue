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

      <b-form-group id="brand" label="Марка:" label-for="brand">
        <b-form-select
          id="brand"
          v-model="form.brand"
          :options="brands"
          required
        ></b-form-select>
      </b-form-group>
       <b-form-group id="model" label="Модель:" label-for="model">
        <b-form-select
          id="model"
          v-model="form.model"
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

 <b-form-group id="servise" label="Послуга:" label-for="servise">
        <b-form-select
          id="servise"
          v-model="form.servise"
          :options="servise"
          required
        ></b-form-select>
      </b-form-group>
 <b-form-textarea id="textarea"  placeholder="Короткий опис роботи" >
   <b-form-select
      id="textarea"
      v-model="form.textarea"
          :options="textarea"
          required
      ></b-form-select>
    </b-form-textarea >

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
          model: '',
          VehicleRegistrationNumber: '',
          brand: null,
          servise:'',
          textarea :'',
        },
        brands: [{ text: '', value: null }, 'Range Rover', 'Ravon', 'Acura', 'Alfa Romeo','Audi','BMW','Brilliance','Buick','BYD','Cadillac','Chery','Chevrolet','Citroen','Daewoo','Daihatsu','Fiat','Ford','Geely','GMC','Great Wall','Honda','Hummer','Hyundai','Infiniti','JAC','Jeep','Kia','Lancia','Land Rover','Lexus','Mazda','Mercedes-Benz','Mercury','MG','Mini','Mitsubishi','Nissan','Opel','Peugeot','Porsche','Renault','SEAT','Skoda','Smart','SsangYong','Subaru','Suzuki','Toyota','Vauxhall','Volkswagen','Volvo',],
        show: true,
        servise: [{ text: '', value: null }, 'Замена прокладки ГБЦ ','Ремонт стартера','Чистка дроссельной заслонки','Замена сальников','Замена стартера','Чистка впускного коллектора','Замена термомуфты','Замена помпы ','Диагностика бензинового двигателя','Промывка топливной системы','Замена подушки двигателя'],
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
        this.form.tel = ''
        this.form.model = ''
        this.form.number_car = ''
        this.form.brand = null
        this.form.service = ''
        this.form.textarea=''
        // Trick to reset/clear native browser form validation state
        this.show = false
        this.$nextTick(() => {
          this.show = true
        })
      }
    }
  }
</script>