<template src="./Calendar.html"/>
<script charset="utf-8">
import Vue from 'vue'
import FullCalendar from "@fullcalendar/vue";

import resourceTimelinePlugin from "@fullcalendar/resource-timeline";

import interactionPlugin from "@fullcalendar/interaction";
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
        interactionPlugin
      ],
       tooltip: {target:'forempty', content : '', key : 0},
        calendarType: 'resourceTimelineDay'
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
      if(event.extendedProps.queryObject.description !== null && event.extendedProps.queryObject.description.length > 1)
        description = '<br>' + event.extendedProps.queryObject.description;

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
      var event = this.$parent.events.filter(obj => { return obj.queryObject.id == object.event.id});
          if(event[0].queryObject != null) {   
             event[0].queryObject.startTime = moment(new Date(object.event.start.setHours(object.event.start.getHours() - 3))).format("YYYY-MM-DD HH:mm:ss");
             event[0].queryObject.endTime =  moment(new Date(object.event.end.setHours(object.event.end.getHours() - 3))).format("YYYY-MM-DD HH:mm:ss");
             if(object.newResource != null)
              event[0].queryObject.workPlaceID = object.newResource.id;
             this.$parent.saveQuery(event[0].queryObject, () => {  }, (error) => { console.log(error) })
          }
    }
  }
};
  (function (global, factory) {
    typeof exports === 'object' && typeof module !== 'undefined' ? module.exports = factory() :
    typeof define === 'function' && define.amd ? define(factory) :
    (global = global || self, (global.FullCalendarLocales = global.FullCalendarLocales || {}, global.FullCalendarLocales.uk = factory()));
}(this, function () { 'use strict';

    var uk = {
        code: "uk",
        buttonText: {
            prev: "Попередній",
            next: "далі",
            today: "Сьогодні",
            month: "Місяць",
            week: "Тиждень",
            day: "День",
            list: "Порядок денний"
        },
        weekLabel: "Тиж",
        allDayText: "Увесь день",
        noEventsMessage: "Немає подій для відображення"
    };

    return uk;

}));


</script>
<style lang='scss'>

 @import "Calendar.scss"; 
</style>