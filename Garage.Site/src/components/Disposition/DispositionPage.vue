<template src="./DispositionPage.html"/>
<script charset="utf-8">
import FullCalendar from "@fullcalendar/vue";
import resourceTimelinePlugin from "@fullcalendar/resource-timeline";
import interactionPlugin from "@fullcalendar/interaction";
import timeGridPlugin from "@fullcalendar/timegrid";
import MaskedInput from "vue-masked-input";
import axios from "axios";
import DetailsTable from "@/components/TableDetails/DetailsTable";
import moment from "moment";
export default {
  created() {
    this.$store.dispatch("getWorkPlace", { params: { id: 1 } }).then(res => {
      var workplaceData = JSON.parse(JSON.stringify(res.data));
       this.workplaces = workplaceData.map(function(i) {
        return {
          id: i["workPlaceID"],
          title: i["workPlaceName"]
        };
      });
    });  

    this.$store.dispatch("getQueryStatus", { params: { id: 0 } }).then(res => {
      var statusData = JSON.parse(JSON.stringify(res.data));
      this.queryStatuses = statusData.map(function(i) {
        return {
          id: i["queryStatusID"],
          text: i["queryStatusName"],
        };
      });
    });

    this.$store.dispatch("getItem", { params: { id: 0 } }).then(res => {
      var itemsData = JSON.parse(JSON.stringify(res.data));
      this.itemCategories = itemsData.map(function(i) {
        return {
          id: i["itemID"],
          text: i["itemName"],
        };
      });
    });
    this.$store.dispatch("getVendor", { params: { id: 0 } }).then(res => {
      var vendorsData = JSON.parse(JSON.stringify(res.data));
      this.vendors = vendorsData.map(function(i) {
        return {
          id: i["vendorID"],
          text: i["vendorName"],
        };
      });
    });
    this.getEmployees(1); //Masters
    this.getEmployees(2); // Mechanics
    this.getEvents();
  },
  components: {
    FullCalendar,
    MaskedInput,
    DetailsTable
  },
  data() {
    return {
      modal:{
        title: '',
        currentmodal: String
      }
      ,
      form: {   
        id: Number,
        customerID: Number,
        customerFullName: String,
        customerPhoneNumber: String,
        startTime: String,
        endTime: String,
        startDateTime: String,
        vehicleID: Number,
        vendorID: Number,
        vehicleModelID: Number,
        vehicleRegistrationNumber: String,
        workplaceID: Number,
        itemID: Number,
        masterID: Number,
        mechanicID: Number,
        queryDescription: String,
        queryStatusID: Number,
      },
      calendarPlugins: [
        resourceTimelinePlugin,
        timeGridPlugin,
        interactionPlugin
      ],
      workplaces: Array,
      employes: Array,
      queryStatuses: Array,
      vehicleModels: Array,
      vendors: Array,
      itemCategories: Array,
      masters: Array,
      mechanics: Array,
      requestStatus: Array,
      events: Array,
      tooltip: {target:'forempty', content : '', key : 0},
      showDismissibleAlert: false,
      eventModalAlert: String
    };
  },
  computed:{
    date1: function(){
     var date1 = new Date();
     date1.setDate(date1.getDate() - 3);
     return date1.toISOString().slice(0, 10);
    },
    date2: function(){
     var date2 = new Date();
     date2.setDate(date2.getDate() + 3);
    return date2.toISOString().slice(0, 10);
    },
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

  methods: {
    updateStartTime(){
     var startTime = this.cStartDateTime+' '+this.cStartTime;
     return moment(startTime,"YYYY-MM-DD HH:mm").format("YYYY-MM-DD HH:mm:ss");
    }
    ,
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

    mouseEnterEvent(elid, event){
       this.tooltip.target = elid;
       this.tooltip.content = 
       
      '<b>' + event.extendedProps.vendorName + ' ' + event.extendedProps.vehicleModelName +'</b>' + '<br>'+
       '<font color="gray">' +event.extendedProps.employeeLastName + ' ' + event.extendedProps.employeeFirstName + '</font><br>' +
       event.extendedProps.itemName + '<br>' +
       event.extendedProps.queryDescription;

       if(this.$refs.refpopover.target != this.tooltip.target)
       this.tooltip.key++;
    },
    logout() {
      localStorage.removeItem("currentUser");
      delete axios.defaults.headers.common["Authorization"];
      this.$router.push("/");
    },
      eventRender(arg) {
      var elid = arg.el.id = 'event'+arg.event.id;
      arg.el.addEventListener("mouseenter",(evt) =>  this.mouseEnterEvent(elid, arg.event));
    },

    handleSelect(arg) {
      this.form = {}; 
      this.form.startDateTime = new Date(arg.start.setHours(arg.start.getHours() - 3))
      this.form.startTime =new Date(arg.start);
      this.form.endTime = new Date(arg.end.setHours(arg.end.getHours() - 3));
      this.form.workplaceID = arg.resource.id;
      this.modal.currentmodal = 'modal-create';
      this.modal.title = 'Заявка: НОВА'     
      this.$bvModal.show(this.modal.currentmodal);
    },

    eventClick(arg) {
    this.form = {};
    this.modal.currentmodal = 'modal-edit';
    this.modal.title = 'Редагування заявки';
 
    var id = arg.event._def.publicId;
     this.$store
        .dispatch("postQuery", {
          params: {
            from: this.date1,
            to: this.date2,
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
              this.form.id = id;
              this.form.itemID = data[i].itemID;
              this.form.customerFullName = data[i].customerFullName;
              this.form.customerPhoneNumber = data[i].customerPhoneNumber;
              this.$set(this.form, 'startDateTime', new Date(data[i].startTime));
              this.$set(this.form, 'startTime', new Date(data[i].startTime));
              this.$set(this.form, 'endTime', new Date(data[i].endTime));
              this.form.vendorID = data[i].vendorID;
              this.form.vendorText = data[i].vendorName;
              this.form.vehicleModelID = data[i].vehicleModelID;
              this.form.vehicleID = data[i].vehicleID;
              this.form.vehicleModelText = data[i].vehicleModelName;
              this.form.vehicleRegistrationNumber = data[i].vehicleRegistrationNumber;
              this.form.workplaceID = data[i].workPlaceID;
              this.form.masterID = data[i].employeeMasterID;
              this.form.mechanicID = data[i].employeeID;
              this.form.queryStatusID = data[i].queryStatusID;
              this.form.queryDescription = data[i].queryDescription;
              this.form.customerID = data[i].customerID;
            }
          }
        });

      this.$bvModal.show(this.modal.currentmodal);

      this.tooltip.key++;
      this.tooltip.target = 'forempty';
    },
    saveQuery(isNew, isDeleted) {
      this.$store
        .dispatch("setQuery", {
          params: {
            queryID: isNew? 0 : this.form.id,
            workShopID: 1,
            customerFullName: this.form.customerFullName,
            customerPhoneNumber: this.form.customerPhoneNumber,
            startTime: this.updateStartTime(),
            endTime: this.updateEndTime(),
            vehicleID: isNew? 0 : this.form.vehicleID,
            vendorID: this.form.vendorID,
            vehicleModelID:  this.form.vehicleModelID,
            vehicleModificationID: isNew ? 1 : this.form.vehicleModelID,
            vehicleRegistrationNumber: this.form.vehicleRegistrationNumber,
            workPlaceID: this.form.workplaceID,
            itemID: this.form.itemID,
            queryDescription: this.form.queryDescription,
            employeeID: this.form.mechanicID,
            employeeMasterID: this.form.masterID,
            queryStatusID: isNew ? 2 : this.form.queryStatusID,
            customerID: isNew ? 0 : this.form.customerID,
            isDeleted: isDeleted ? true : false
          }
        })
        .then(res => {
           console.log(res);
          this.$bvModal.hide(this.modal.currentmodal);
          this.getEvents();
        }).catch((error) => {
           this.eventModalAlert = error.response.data;
           this.showDismissibleAlert=true;
           setTimeout(() => this.showDismissibleAlert = false, 2000);
        
      console.log(error.response.data)    });
 
    },
    getEvents(){
          this.$store
      .dispatch("getQuery", {
        params: {
          from: this.date1,
          to: this.date2,
          workShopID: 1,
          queryStatusID: 0,
          notShortQuery: 0
        }
      })
      .then(res => {
        var eventsData = JSON.parse(JSON.stringify(res.data));
        this.events = eventsData.map(function(i) {
          return {
            id: i["queryID"],
            resourceId: i["workPlaceID"],
            title: i["vehicleRegistrationNumber"],
            date: i["startTime"],
            end: i["endTime"],
            borderColor: i["queryStatusColor"],
            backgroundColor: i["employeeMasterColor"],
            vendorName: i["vendorName"], //for tooltip
            vehicleModelName: i["vehicleModelName"], // for tooltip
            employeeLastName: i["employeeLastName"], // for tooltip
            employeeFirstName: i["employeeFirstName"],// for tooltip
            itemName: i["itemName"],// for tooltip
            queryDescription: i["queryDescription"],// for tooltip
          };
        });
      });
    },
    getEmployees(postID){
     return this.$store
      .dispatch("getEmployees", {
        params: { workShopID: 1, employeePostID: postID }
      })
      .then(res => {
        var data = JSON.parse(JSON.stringify(res.data));

        if(postID == 1){
        this.masters = data.map(function(i) {
          return {
            id: i["employeeID"],
            text: i["employeeFirstName"] + " " + i["employeeLastName"],
            color: i["employeeColor"]
          };
        });
        }
        if(postID == 2){
         this.mechanics = data.map(function(i) {
          return {
            id: i["employeeID"],
            text: i["employeeFirstName"] + " " + i["employeeLastName"],
            color: i["employeeColor"]
          };
        });
        }
      });
    },
     getSelectedBrand(id) {
      this.$store
        .dispatch("getVehicleModel", { params: { id: id } })
        .then(res => {
          var vendorsData = JSON.parse(JSON.stringify(res.data));
          this.vehicleModels = vendorsData.map(function(i) {
            return {
              id: i["vehicleModelID"],
              text: i["vehicleModelName"]
            };
          });
        });
    },
  }
};
</script>
<style lang='scss'>
@import "~@fullcalendar/core/main.css";
@import "~@fullcalendar/timeline/main.css";
@import "~@fullcalendar/resource-timeline/main.css";
@import "DispositionPage.scss";

</style>