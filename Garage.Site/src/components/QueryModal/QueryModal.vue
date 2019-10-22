<template src="./QueryModal.html"/>
<script charset="utf-8">
import moment from "moment";
import Multiselect from 'vue-multiselect';
import CustomerModal from "@/components/CustomerModal/CustomerModal";
import VehicleModal from "@/components/VehicleModal/VehicleModal";

export default {
   props: {
    parent: Object,
    queryStatuses: null,
    workplaces: null, 
    itemCategories: null,
    masters: null, 
    mechanics: null,
    vendors: null,
    },
    components:{
        Multiselect,
        CustomerModal,
        VehicleModal
    },
    data(){
        return{
    form: {
        ID: Number,
        workShopID: 1,
        workPlaceID: null,
        vehicleID: null,
        customerID: Number,
        startTime: Object,
        endTime: Object,
        itemID: 0,
        employeeMasterID: null,
        employeeID: null,
        description: '',
        isDeleted: null,
        statusID: null,
        startDateTime: Object,
        modaltitle: '',
        //for new input //
        vendor: Object,
        model: Object,
        item : Object,
        employee : Object,
        customer: {id : null},
        vehicle: {id : null},
    
      },
        customers : [],
        vehicles : [],
        showDismissibleAlert: false,
        eventModalAlert: String,
        isNewCustomer: null,
        isNewVehicle: null,
        isLoadingCustomer: false,
        isLoadingVehicle: false,
        key: 0,
        }
    },
    computed:{
    cStartDateTime: function(){
        return moment(this.form.startDateTime, "YYYY-MM-DD").format("YYYY-MM-DD") ;
    },
    cStartTime: function(){
        return moment(this.form.startTime, "HH:mm").format("HH:mm");
    },
     cEndTime: function(){
        return moment(this.form.endTime, "HH:mm").format("HH:mm");
    }
   
    },

    methods :{
  formatedPhone(p){
    if(p != null && p.length === 10)
      return p.replace(/(\d{3})(\d{3})(\d{4})/g, '$1 $2 $3');
      else return p;
    },
   validateName(event){
       var k = event.key;
       if(event.keyCode > 50){
         var p = new RegExp("[А-ЩЬЮЯҐЄІЇа-щьюяґєії]");
   	     if (!p.test(k)) 
        event.preventDefault()
        }
    },

    updateStartTime(){
     var startTime = this.cStartDateTime+' '+this.cStartTime;
     return moment(startTime,"YYYY-MM-DD HH:mm").format("YYYY-MM-DD HH:mm:ss");
    },
    updateEndTime(){
      var endTime = this.cStartDateTime+' '+this.cEndTime;
      return moment(endTime,"YYYY-MM-DD HH:mm").format("YYYY-MM-DD HH:mm:ss");
    },

    stringToDateTime(value){
        this.form.startDateTime = value;
        this.form.startTime = this.cStartTime;
        this.form.endTime = this.cEndTime;
    },
    stringToStartTime(value){
        this.form.startDateTime = this.cStartDateTime; 
        this.form.startTime = value; 
        this.form.endTime = this.cEndTime;
    },
    stringToEndTime(value){
        this.form.startDateTime = this.cStartDateTime; 
        this.form.startTime = this.cStartTime;
        this.form.endTime = value; 
    },
    customLabel(option){
 
       return option.text;
    },
    openModal: function(arg,date1,date2,currentUser) {
        if(arg.event != null) {
        
              this.loadForm(arg.event.id,date1,date2)
        } 
        else{
             this.form.startDateTime = new Date(arg.start.setHours(arg.start.getHours() - 3))
             this.form.startTime =new Date(arg.start);
             this.form.endTime = new Date(arg.end.setHours(arg.end.getHours() - 3));
             this.form.workPlaceID = parseInt(arg.resource.id, 10);
             this.form.employeeMasterID = currentUser.employeeID;
             this.form.statusID = 2;
             this.form.ID = 0;
             this.form.vehicleID = 0;
             this.form.vehicleModificationID = 1;
             this.form.customerID = 0
             this.form.modaltitle = 'Створення нової заявки';
        }
              this.$bvModal.show('modalQuery');
    },
    loadForm: function(queryID,date1,date2) {
            this.parent.$store.dispatch("getQuery", {
            params: {
            from: date1,
            to: date2,
            workShopID: 1,
            statusID: 0,
            notShortQuery: 0,
            ID: queryID
          }
        })
        .then(res => {
          var data = JSON.parse(JSON.stringify(res.data));
          for (var i = 0; i < data.length; i++) {
            if (data[i].id == queryID) {
              console.log(data[i]);
              this.form = data[i];
              this.form.vehicle = {id : data[i].vehicleID, modelName : data[i].vehicleModelName, vendorName: data[i].vendorName, registrationNumber: data[i].vehicleRegistrationNumber }
              this.form.customer = {id : data[i].customerID, fullName : data[i].customerFullName, phoneNumber: data[i].customerPhoneNumber, phoneCountryCode: data[i].phoneCountryCode  }
              this.form.employee = data[i].employeeID !== 0 ? {id : data[i].employeeID, text : data[i].employeeLastName + ' ' + data[i].employeeFirstName} : {}
              this.form.item = {id : data[i].itemID, text : data[i].itemName}
              this.$set(this.form, 'startDateTime', new Date(data[i].startTime));
              this.$set(this.form, 'startTime', new Date(data[i].startTime));
              this.$set(this.form, 'endTime', new Date(data[i].endTime));
              this.$set(this.form, 'modaltitle', 'Редагування заявки №' + data[i].id);
            }
          }
        });
   },

    saveForm(isDeleted) {
      var copyForm = JSON.parse(JSON.stringify(this.form));

          copyForm.startTime = this.updateStartTime();
          copyForm.endTime =  this.updateEndTime();
          copyForm.vehicleID =  this.form.vehicle.id;
          copyForm.customerID =  this.form.customer.id;
          copyForm.employeeID = this.form.employee.id;
          copyForm.isDeleted = isDeleted;

        //  copyForm.itemID =  this.getId(this.form.item); НЕ УДАЛЯТЬ 
         

          if( this.form.queryDescription == null || this.form.queryDescription.length < 1 )
            copyForm.queryDescription = '';

          this.parent.saveQuery(copyForm,
          () => {
             this.$bvModal.hide('modalQuery') },
          (error) =>{
            console.log(error);
             this.eventModalAlert = error.response.data;
             this.showDismissibleAlert=true;
             });
    },
    openCustomerModal(isNew){
      this.isNewCustomer = isNew;
      if(!this.isNewCustomer) {
      this.$refs.customerModal.loadForm(this.form.customer.id);
      }
      else {
          this.$refs.customerModal.createForm();
      }
      this.$bvModal.show('modalCustomer');
    },

    openVehicleModal(isNew){
      this.isNewVehicle= isNew;
      if(!this.isNewVehicle) {
      this.$refs.vehicleModal.loadForm(this.form.vehicle.id);
      }
      else {
        this.$refs.vehicleModal.createForm();
      }
      this.$bvModal.show('modalVehicle');
    },

    asyncSearchCustomer(searchChars){
           if(searchChars.length < 1){ 
          return;}
      this.isLoadingCustomer = true;
      this.parent.$store.dispatch("getCustomer", { params: { id: 0, searchChars : searchChars } }).then(res => {
     this.customers = JSON.parse(JSON.stringify(res.data));
      this.isLoadingCustomer = false;
    });
    },

    updateCustomerSelect(i){
      this.$set(this.form, 'customer', i);
      this.setCustomerVehicle(i.id);
    },
     updateVehicleSelect(i){
       this.$set(this.form, 'vehicle', i);
       this.setVehicleCustomer(i.id);
    },
     asyncSearchVehicle(searchChars){      
      this.isLoadingVehicle = true;
      this.parent.$store.dispatch("getVehicle", { params: { id: 0, searchChars : searchChars } }).then(res => {
      this.vehicles = JSON.parse(JSON.stringify(res.data));
      this.isLoadingVehicle = false;
    });
    },
    updateCustomer(customer){
       this.$set(this.form, 'customer', customer);
       this.$set(this.form, 'customerID', customer.id);
       this.key++;
     },
    updateVehicle(vehicle){
       this.$set(this.form, 'vehicle', vehicle);
       this.$set(this.form, 'vehicleID', vehicle.id);
       this.key++;
     },

     setCustomerVehicle(customerID){
     this.parent.$store.dispatch("getVehiclesByCustomer", { params: { customerID} }).then(res => {
     var vehiclesByCustomer = JSON.parse(JSON.stringify(res.data));
      if(vehiclesByCustomer.length > 0){
        this.form.vehicle = vehiclesByCustomer[0];
        this.form.vehicleID = vehiclesByCustomer[0].id;
      }
      this.key++;
    });
     },
     setVehicleCustomer(vehicleID){
     this.parent.$store.dispatch("getCustomersByVehicle", { params: { vehicleID} }).then(res => {
     var customersByVehicle = JSON.parse(JSON.stringify(res.data));
      if(customersByVehicle.length > 0){
        console.log(customersByVehicle);
        this.form.customer= customersByVehicle[0];
        this.form.customerID = customersByVehicle[0].id;
      }
      this.key++;
    });
     }
    }
}
</script>

 <style lang="scss">
    @import "~vue-multiselect/dist/vue-multiselect.min.css";
    @import "~bootstrap/scss/functions";
    @import "~bootstrap/scss/variables";
    @import "QueryModal.scss";
    p#error{
    margin-bottom: 0;
}
</style>
