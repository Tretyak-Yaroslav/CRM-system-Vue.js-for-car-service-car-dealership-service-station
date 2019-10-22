<template src="./DispositionPage.html"/>
<script charset="utf-8">
import Vue from 'vue'
import axios from "axios";
import Calendar from "@/components/Calendar/Calendar";
import CalendarGrid from "@/components/Calendar/CalendarGrid";
import DetailsTable from "@/components/TableDetails/DetailsTable";
import QueryModal from "@/components/QueryModal/QueryModal";
import moment from "moment";

export default {
  created() {
    this.currentUser = JSON.parse(localStorage.getItem("currentUser"));
    if (this.currentUser) {
      axios.defaults.headers.common["Authorization"] =
        "Bearer " + this.currentUser.token;
    }

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
    this.getEmployees(1); //Masters
    this.getEmployees(2); // Mechanics
    this.getEvents();
  },
  components: {
    Calendar,
    CalendarGrid,
    DetailsTable
  },
  data() {
    return {
      workplaces: Array,
      queryStatuses: Array,
      vendors: Array,
      customers: Array,
      itemCategories: Array,
      masters: Array,
      mechanics: Array,
      events: Array,
      tableitems: Array,
      currentUser : Object,
      isgrid: false,
      key: 0
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
  },

  methods: {
    logout() {
      localStorage.removeItem("currentUser");
      delete axios.defaults.headers.common["Authorization"];
      this.$router.push("/");
    },
    changeView(){
      if (this.isgrid === true)
        this.isgrid = false;
        else 
        this.isgrid = true;

    },
    getEvents(){
          this.$store
      .dispatch("getQuery", {
        params: {
          from: this.date1,
          to: this.date2,
          workShopID: 1,
          statusID: 0,
          notShortQuery: 0,
          ID: 0
        }
      })
      .then(res => {
        var eventsData = JSON.parse(JSON.stringify(res.data));
        this.events = eventsData.map(function(i) {
          return {
            id: i["id"],
            resourceId: i["workPlaceID"],
            title: i["vehicleRegistrationNumber"],
            start: i["startTime"],
            end: i["endTime"],
            borderColor: i["statusColor"],
            backgroundColor: i["employeeMasterColor"],
            queryObject: i,
          };
        });
        this.createTableItems(eventsData);

      });
    },
    saveQuery(query,callback, errorcallback){
      this.$store
        .dispatch("setQuery", {
          params: {}, data: query
        })
        .then(res => {
          this.getEvents();
          if(callback) 
          callback(); 

        }).catch((error) => {
            console.log(error);
          errorcallback(error);
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
            text: i["employeeLastName"] + " " + i["employeeFirstName"],
            color: i["employeeColor"]
          };
        }).sort(function(a, b) {
          return (a < b) ? -1 : (a > b) ? 1 : 0;
        });
        }
        if(postID == 2){
         this.mechanics = data.map(function(i) {
          return {
            id: i["employeeID"],
            text: i["employeeLastName"] + " " + i["employeeFirstName"],
            color: i["employeeColor"]
          };
        }).sort(function(a, b) {
          return (a < b) ? -1 : (a > b) ? 1 : 0;
        });
        }


      });
    },
    createModalInstance(arg){
      var ModalClass = Vue.extend(QueryModal)

      var instance = new ModalClass({propsData: {
        parent: this,
        queryStatuses: this.queryStatuses, 
        workplaces: this.workplaces, 
        itemCategories: this.itemCategories,
        masters: this.masters, 
        mechanics: this.mechanics,
        vendors: this.vendors,
        
        }})

        instance.$mount()

        this.$refs.modalcontainer.appendChild(instance.$el)
        instance.openModal(arg, this.date1, this.date2, this.currentUser);
  },
    createTableItems(eventsData){    
    this.tableitems = eventsData.map(function(i) {
          return {
            queryObject: i,
            queryID: i["ID"],
            DateTime: moment(String(i["startTime"])).format("L"),
            queryStatusName: i["statusName"],
            variant: i["statusColor"],
            customerPhoneNumber: i["customerPhoneNumber"],
            startTime: moment(String(i["startTime"])).format("LT") +' - '+moment(String(i["endTime"])).format("LT"),
          /*  employeeID: {
              employeeFirstName: i["employeeFirstName"],
              employeeLastName: i["employeeLastName"]
            }, */
            modelAndMakeCar:  i["vendorName"] +' '+i["vehicleModelName"],
            vehicleRegistrationNumber: i["vehicleRegistrationNumber"],
            employeeMaster: i["employeeMasterLastName"] + ' ' + i["employeeMasterFirstName"],
            itemName: i["itemName"],
            queryDescription: i["description"]
          };
        });
  }
  }
};
</script>
<style lang='scss'>
@import "~@fullcalendar/core/main.css";
@import "~@fullcalendar/timeline/main.css";
@import "~@fullcalendar/resource-timeline/main.css";
@import "~@fullcalendar/timegrid/main.css";
//@import "DispositionPage.scss";
</style>