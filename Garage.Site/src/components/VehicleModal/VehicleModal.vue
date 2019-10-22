<template src="./VehicleModal.html"/>
<script charset="utf-8">
import Multiselect from 'vue-multiselect';

export default {
    created(){

            this.$parent.parent.$store.dispatch("getVendor", { params: { id: 0, isVisible: true } }).then(res => {
            var vendorsData = JSON.parse(JSON.stringify(res.data));
            this.vendors = vendorsData.map(function(i) {
            return {
                    id: i["vendorID"],
                    text: i["vendorName"],
            };
      });
    });

    },
   props: {
       isNew: null
    },
    components:{
        Multiselect
    },
    data(){
        return{
    form: {
      id: null,
      vendorID : null,
      modelID: null,
      vendor: {id : null},
      model: {id : null},
      registrationNumber: null,
      vinNumber: null,
      description: null,
      isVisible: false,
      },
      vehicleModels: [],
      vendors: [],
      key: 0,
      stateVin: null,
    }
    },
    computed:{
   
    },

    methods :{
    validateRegNumber(event){
      if( (event.keyCode < 49 || event.code.includes("Digit") || event.code.includes("Numpad") ) || event.ctrlKey )
        return;
        event.preventDefault();
        var symFromCode = event.code.substring(3)
        if (symFromCode.length == 1) {
         var k = symFromCode.toUpperCase();
         var p = new RegExp("[A-Z0-9]");
        if (p.test(k))
          event.target.value += k;
        }
    },

    saveForm(isDeleted){
        if (this.isNew) this.form.id = 0;
        if (this.form.registrationNumber.match(/[a-z]/i)) {
              this.form.registrationNumber.toUpperCase();
        }
        this.form.vendorID = this.form.vendor.id;
        this.form.modelID= this.form.model.id;
      this.$parent.parent.$store
        .dispatch("setVehicle",   { params: {}, data: this.form})
        .then(res => {
          this.$bvModal.hide('modalVehicle')
          var vehicle = {id : this.isNew? res.data : this.form.id , vendor:this.form.vendor.text, model:this.form.model.text,  number :this.form.registrationNumber }
          this.$parent.updateVehicle(vehicle);
        }).catch((error) => {
            console.log(error);
        });
    },
    loadForm: function(vehicleID) {
            this.$parent.parent.$store.dispatch("getVehicle", {
            params: {
            id: vehicleID, searchChars: ''
          }
        })
        .then(res => {
          var data = JSON.parse(JSON.stringify(res.data));
          this.getSelectedBrand(null,data[0]);
          this.form = data[0];
          this.form.vendor = {id:data[0].vendorID, text: data[0].vendorName};
          this.form.model = {id:data[0].modelID, text: data[0].modelName};
        });
   },
   createForm(){
       Object.entries(this.form).forEach(([key, val]) => {
            this.$set(this.form, key, null);
            });

    },

     getSelectedBrand(item, i) {
      var id = i != null ? i.vendorID: item.id;
      this.$parent.parent.$store
        .dispatch("getVehicleModel", { params: { id: id } })
        .then(res => {
          var modelData = JSON.parse(JSON.stringify(res.data));
          this.vehicleModels = modelData.map(function(i) {
            return {
              id: i["vehicleModelID"],
              text: i["vehicleModelName"]
            }; 
            });
         
         if(i == null){ 
         this.form.model = null;
        }     
        });
    },
    updateModel(i){
            this.key++;
           this.$set(this.form, 'model', { id:i.id, text: i.text});
                   
    },
    checkVin(vin){
    if (vin.length === 0) return this.stateVin = null;
        vin = vin.toLowerCase();
        if (!/^[a-hj-npr-z0-9]{9}[a-hj-npr-z0-9]{8}$/.test(vin)) {
             this.stateVin =false; 
            return false;
        }
     this.stateVin = true;
     this.form.vinNumber = vin;
        },
    } 
}
</script>

 <style lang="scss">


</style>
