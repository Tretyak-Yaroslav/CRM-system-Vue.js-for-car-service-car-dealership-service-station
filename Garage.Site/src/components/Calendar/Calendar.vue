<template src="./Calendar.html"/>
<script charset="utf-8">
import Vue from 'vue'
import FullCalendar from "@fullcalendar/vue";
import resourceTimelinePlugin from "@fullcalendar/resource-timeline";
import interactionPlugin from "@fullcalendar/interaction";
import timeGridPlugin from "@fullcalendar/timegrid";
import moment from "moment";

export default {
  name: "fullcalendar",
  props: {
     events : null,
     workplaces : null
   },
  components: {
    FullCalendar
  },
  data() {
    return {
     calendarPlugins: [
        resourceTimelinePlugin,
        timeGridPlugin,
        interactionPlugin
      ],
       tooltip: {target:'forempty', content : '', key : 0}
    };
  },
  methods: {
    mouseEnterEvent(elid, event){
       this.tooltip.target = elid;
        var employeeName = '';
        var description = '';


      var vendorName = event.extendedProps.queryObject.vendorName + ' '; // НЕ УДАЛЯТЬ + event.extendedProps.queryObject.vehicleModelName;
      if(event.extendedProps.queryObject.employeeLastName !== null && event.extendedProps.queryObject.employeeFirstName !== null){

             employeeName = '<br>'+ event.extendedProps.queryObject.employeeLastName  + ' ' + event.extendedProps.queryObject.employeeFirstName;
      }
   
      var itemName = event.extendedProps.queryObject.itemName;
      if(event.extendedProps.queryObject.queryDescription !== null && event.extendedProps.queryObject.queryDescription.length > 1)
        description = '<br>' + event.extendedProps.queryObject.queryDescription;

       this.tooltip.content = 
       '<b>' + vendorName +'</b>'+ 
       '<font color="gray">' + employeeName + '</font>' + /*itemName + '<br>' +*/ description;
       if(this.$refs.refpopover.target != this.tooltip.target)
       this.tooltip.key++;
    },

    eventRender(arg) {
      var elid = arg.el.id = 'event'+arg.event.id;
      arg.el.addEventListener("mouseenter",(evt) =>  this.mouseEnterEvent(elid, arg.event));
    },

    eventClick(arg) {
      this.$parent.createModalInstance(arg)
      this.tooltip.key++;
      this.tooltip.target = 'forempty';
    },
 
    updateEvent(object){
      var event = this.$parent.events.filter(obj => { return obj.queryObject.queryID == object.event.id});
          if(event[0].queryObject != null) {   
             event[0].queryObject.startTime = moment(new Date(object.event.start.setHours(object.event.start.getHours() - 3))).format("YYYY-MM-DD HH:mm:ss");
             event[0].queryObject.endTime =  moment(new Date(object.event.end.setHours(object.event.end.getHours() - 3))).format("YYYY-MM-DD HH:mm:ss");
             if(object.newResource != null)
              event[0].queryObject.workPlaceID = object.newResource.id;
             this.$parent.saveQuery(event[0].queryObject, false, false, () => { this.$parent.getEvents() }, (error) => { console.log(error) })
          }
    }
  }
};
</script>
<style lang='scss'>
@import "~@fullcalendar/core/main.css";
@import "~@fullcalendar/timeline/main.css";
@import "Calendar.scss";
</style>