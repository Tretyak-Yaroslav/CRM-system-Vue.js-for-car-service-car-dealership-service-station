<template src="./QueryModal.html"/>
<script charset="utf-8">
import moment from "moment";
import MaskedInput from "vue-masked-input";
import Multiselect from 'vue-multiselect'

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
        MaskedInput,
        Multiselect
    },
    data(){
        return{
    form: {
        modaltitle: '',
        queryID: Number,
        customerID: Number,
        customerFullName: null,
        customerPhoneNumber: null,
        startTime: Object,
        endTime: Object,
        startDateTime: Object,
        vehicleID: null,
        vendorID: null,
        vehicleModelID: null,
        vehicleRegistrationNumber: null,
        workPlaceID: null,
        itemID: 0,
        employeeMasterID: null,
        employeeID: null,
        queryDescription: '',
        queryStatusID: null,

        //for new input //
        vendor: Object,
        model: Object,
        item : Object,
        employee : Object
      },
        vehicleModels: [],
        showDismissibleAlert: false,
        eventModalAlert: String,
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
    },
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
             this.form.queryStatusID = 2;
             this.form.queryID = 0;
             this.form.vehicleID = 0;
             this.form.vehicleModificationID = 1;
             this.form.customerID = 0

             this.form.modaltitle = 'Створення нової заявки';
        }
              this.$bvModal.show('modalQuery');
    },
    loadForm: function(id,date1,date2) {
            this.parent.$store.dispatch("postQuery", {
            params: {
            from: date1,
            to: date2,
            workShopID: 1,
            queryStatusID: 0,
            notShortQuery: 0,
            queryID: id
          }
        })
        .then(res => {
       
          var data = JSON.parse(JSON.stringify(res.data));
          
          for (var i = 0; i < data.length; i++) {
       
            if (data[i].queryID == id) {

              this.getSelectedBrand(null,data[i].vendorID);
              this.$set(this.form, 'modaltitle', 'Редагування заявки №' + data[i].queryID);
              this.form.queryID = id;
              this.form.itemID = data[i].itemID;
              this.form.customerFullName = data[i].customerFullName;
              this.form.customerPhoneNumber = data[i].customerPhoneNumber;
              this.$set(this.form, 'startDateTime', new Date(data[i].startTime));
              this.$set(this.form, 'startTime', new Date(data[i].startTime));
              this.$set(this.form, 'endTime', new Date(data[i].endTime));
              this.form.vendor = {id :data[i].vendorID, text : data[i].vendorName}
              this.form.model = {id :data[i].vehicleModelID, text : data[i].vehicleModelName}
              this.form.item = {id : data[i].itemID, text : data[i].itemName}
              this.form.employee = data[i].employeeID !== 0 ? {id : data[i].employeeID, text : data[i].employeeLastName + ' ' + data[i].employeeFirstName} : {}
              this.form.vehicleID = data[i].vehicleID;
              this.form.vehicleRegistrationNumber = data[i].vehicleRegistrationNumber;
              this.form.workPlaceID = data[i].workPlaceID;
              this.form.employeeMasterID = data[i].employeeMasterID;
              this.form.employeeID= data[i].employeeID;
              this.form.queryStatusID = data[i].queryStatusID;
              this.form.queryDescription = data[i].queryDescription;
              this.form.customerID = data[i].customerID;
            }
          }
        });
   },


    saveForm(isDeleted) {
      var copyForm = JSON.parse(JSON.stringify(this.form));
          copyForm.startTime = this.updateStartTime();
          copyForm.endTime =  this.updateEndTime();
          copyForm.vendorID =  this.getId(this.form.vendor);
          copyForm.vehicleRegistrationNumber = this.form.vehicleRegistrationNumber.toUpperCase();
  //
          
          copyForm.vehicleModelID = this.vehicleModels[0].id //without ModelName
         // copyForm.vehicleModelID = this.getId(this.form.model) ; НЕ УДАЛЯТЬ 

        //  copyForm.itemID =  this.getId(this.form.item); НЕ УДАЛЯТЬ 
          copyForm.employeeID = this.getId(this.form.employee);

          if( this.form.queryDescription == null || this.form.queryDescription.length < 1 )
            copyForm.queryDescription = '';

          this.parent.saveQuery(copyForm, isDeleted, 
          () => {
             this.$bvModal.hide('modalQuery') },
          (error) =>{
            console.log(error);
             this.eventModalAlert = error.response.data;
             this.showDismissibleAlert=true;
            
             });
    },
    
     getSelectedBrand(item, i) {
      
      var id = i != null ? i: item.id;
      this.parent.$store
        .dispatch("getVehicleModel", { params: { id: id } })
        .then(res => {
          this.form.vehicleModelID = null;
          
          var vendorsData = JSON.parse(JSON.stringify(res.data));
          this.vehicleModels = vendorsData.map(function(i) {
            return {
              id: i["vehicleModelID"],
              text: i["vehicleModelName"]
            };
          });
        });
    },
    getId(item){
      return item.id;
    },
    
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
