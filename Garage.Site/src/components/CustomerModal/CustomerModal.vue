<template src="./CustomerModal.html"/>
<script charset="utf-8">
import { VueTelInput } from 'vue-tel-input'

export default {
   props: {
       isNew: null
    },
    components:{
        VueTelInput,
    },
    data(){
        return{
    form: {
      workShopID: 1,
      id: null,
      fullName: null,
      shortName: null,
      phoneNumber: null,
      mail: null,
      individualOrEntityPerson: null,
      inn: null,
      codeEDRPOU: null,
      entityPersonNumber: null,
      isDeleted: false,
      phoneCountryCode: null,
      },
      key: 0,
      phoneCode: "UA",
      validationPhone: true,
      customerVehicles: {},
 
        }
    },
    
    computed:{
   
    },

    methods :{
    saveForm(isDeleted){
        if(this.form.phoneNumber.length < 10) {
          console.log("false")
          this.validationPhone = false;
          return;
        }
        else{
            this.validationPhone = true;
            this.form.phoneNumber = this.form.phoneNumber.replace(/\D/g, '');
        }

        if (this.isNew) this.form.id = 0;
        this.form.IndividualOrEntityPerson = this.form.IndividualOrEntityPerson ? "Юр.лицо" : "Физ.лицо" 
 
      this.$parent.parent.$store
        .dispatch("setCustomer", 
           { params: {}, data: this.form}
        )
        .then(res => {
          this.$bvModal.hide('modalCustomer')
          var customer = {id : res.data, name:this.form.fullName, phone:this.form.phoneNumber, phoneCode: this.form.phoneCountryCode}
          this.$parent.updateCustomer(customer);

        }).catch((error) => {
            console.log(error);
           });
    },
    
    loadForm: function(customerID) {
            this.$parent.parent.$store.dispatch("getCustomer", {
            params: { id: customerID, searchChars: ''}})
        .then(res => {
          var data = JSON.parse(JSON.stringify(res.data));
          data[0].individualOrEntityPerson = data[0].individualOrEntityPerson == "Юр.лицо" ? true : false ;
          this.form = data[0];
          
          var code = this.$refs.phone.allCountries.find(obj => {
            return obj.dialCode === this.form.phoneCountryCode});
            if(code != null){
                this.phoneCode = code.iso2;
            }

          this.key++;

        });


      this.$parent.parent.$store.dispatch("getVehiclesByCustomer", { params: {customerID : customerID}})
        .then(res => {
         this.customerVehicles = JSON.parse(JSON.stringify(res.data));
     
console.log(this.customerVehicles);

        });
   },

   createForm(){
      Object.entries(this.form).forEach(([key, val]) => {
            this.$set(this.form, key, null);
            });
    this.form.workShopID = 1
        },
        updatePhone(o){
          //console.log(o);
         // console.log(this.$refs.phone);

          this.form.phoneCountryCode = o.dialCode
        },
    } 
}
</script>

 <style lang="scss">
.vti__selection{
  font-size: 1rem!important;
}

</style>
