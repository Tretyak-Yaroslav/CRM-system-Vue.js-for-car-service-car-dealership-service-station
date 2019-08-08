<template>
  <div style="margin:0px 10px;">
    <div class="logo">
      <img src="../../src/assets/logo_ad.png" alt="logo">
    </div>
    <FullCalendar
      :plugins="calendarPlugins"
      defaultView="resourceTimelineDay"
      locale="uk"
      nowIndicator="true"
      :header="{
                        left: 'prev,next today',
                        center: 'title',
                        right: 'resourceTimelineDay,resourceTimelineWeek'
                      }"
      displayEventTime="true"
      displayEventEnd="true"
      selectable="true"
      :eventTimeFormat="{
                        hour: 'numeric',
                        minute: '2-digit',
                        meridiem: false
                      }"
      :resources="resources"
      :events="events"
      @dateClick="handleDateClick"                
    />

 <b-button v-b-modal.modal-center>Open Modal</b-button>
    <b-modal id="modal-center" ref="modal" title="Опрацювання заявки :">
      <div class="form-group">
        <label class="control-label">Статус</label>
        <select class="form-control order-status" name="order[status]">
          <option selected="selected" value="1">Нова</option>
          <option value="2">Прийнята</option>
          <option value="3">В роботі </option>
        <option value="4">Виконана</option>
        <option value="5">Відмова</option>
        </select>
      </div>
            <div class="form-group">
        <label class="control-label">Перелік заявок:</label>
        <select
          name="application"
          id="application"
          class="form-control slot-select"
        >
          <option value label=""></option>
        </select>
      </div>
      <div class="form-group">
        <label class="control-label">Мастер</label>
        <b-form-select
            id="master"
            v-model="form.master"
            :options="masters"
             required
          ></b-form-select>
      </div>
      <div class="form-group">
        <label class="control-label">Механік</label>
        <b-form-select
            id="mechanic"
            v-model="form.mechanic"
            :options="mechanics"
             required
          ></b-form-select>
      </div>
      
       <div class="form-group">
        <label class="control-label">Послуга</label>
        <select
          name="service"
          id="service"
          class="form-control slot-select"
        >
          <option value label=""></option>
        </select>
      </div>
      <div class="row">
        <div class="col-6 if-available left">
          <div class="form-group">
            <label class="control-label">Ім'я:</label>
            <input
              placeholder="Введіть ім'я"
              class="form-control"
              type="text"
              name="name"
              id="CustomerFullName"
            />
          </div>
        </div>
        <div class="col-6 if-available right">
          <div class="form-group">
            <label class="control-label">Телефон</label>
            <input type="tel" class="form-control" name="phone" id placeholder="+380960547444" />
          </div>
        </div>
        <div class="datatime">
          <label class="control-label">Початок роботи</label>
          <!-- <datetime type="datetime" v-model="datetimefrom" format="yyyy-MM-dd HH:mm:ss"></datetime> -->
          <datetime type="datetime" format="yyyy-MM-dd HH:mm:ss"></datetime>
        </div>
        <div class="datatime">
          <label class="control-label">Закінчення роботи</label>
          <!-- v-model="datetimeto" -->
          <datetime type="datetime"  format="yyyy-MM-dd HH:mm:ss"></datetime>
        </div>
      </div>
      
      <b-form-textarea
        id="textarea-default"
        size="md"
        placeholder="Коментар"
      ></b-form-textarea>
    
    </b-modal>
  </div>
</template>

<script charset="utf-8">
import FullCalendar from "@fullcalendar/vue";
import resourceTimelinePlugin from "@fullcalendar/resource-timeline";
import interactionPlugin from '@fullcalendar/interaction'; 
import timeGridPlugin from '@fullcalendar/timegrid' ;



export default {
  created() {
      this.$store.dispatch("getWorkPlace", { params: { id: 1 } }).then(res => {
        var resourcesData = JSON.parse(JSON.stringify(res.data));
        this.resources = resourcesData.map(function(i) {
          return {
            id: i["workPlaceID"],
            title: i["workPlaceName"]
          };});
      });

      this.$store.dispatch("getEmployees", { params: { workShopID : 1, employeePostID : 1 } }).then(res => {
        var vendorsData = JSON.parse(JSON.stringify(res.data));
        this.masters = vendorsData.map(function(i) {
          return {
            text: i["employeeFirstName"] + i["employeeLastName"],
            value: i["employeeID"]
          };
        });
      });

      this.$store.dispatch("getEmployees",{params:{ workShopID : 1, employeePostID : 2 }})
        .then(res =>{
          var mechanicData =JSON.parse(JSON.stringify(res.data));
          console.log(mechanicData);
          this.mechanics = mechanicData.map(function(i){
            return{
              text: i["employeeFirstName"] + i["employeeLastName"],
              value: i["employeeID"]
            }
        });
      });
      // this.$store.dispatch("getOrder", {params:{
      //   from: "2019-08-01", 
      //   to: "2019-08-09", 
      //   workShopID: 1, 
      //   orderStatusID: 0, 
      //   notShortOrder:0
      // }}).then(res=>{
      //   var eventsData = JSON.parse(JSON.stringify(res.data));
      //   console.log(eventsData);
      //   this.events = eventsData.map(function(i){
      //       return{
      //         id: i["orderID"],
      //         resourceId: i["workPlaceID"],
      //         title: i["vendorName"],
      //         date: '2019-08-07 08:00:00',
      //         end: '2019-08-07 18:00:00',
      //         textColor:'white',
      //         class:'in_work',
      //         backgroundColor:'rgb(88, 218, 156) '
      //       }
      //   });
      // });
                          
  },
  components: {
    FullCalendar
  },
  
  data() {
    return {
      form:{
        master:"",
        mechanic:"",
        employes:""
      },
      calendarPlugins: [
        resourceTimelinePlugin,
        timeGridPlugin,  
        interactionPlugin 
      ],
      selectable: true,
      calendarEvents: [
        { title: 'Event Now', start: new Date() }
      ],
      resources:[],
      employes:[],
      masters: [],
      mechanics:[],
      events:[]
    };
  },
 
  methods:{
     toggleWeekends() {
      this.calendarWeekends = !this.calendarWeekends // update a property
    },
    gotoPast() {
      let calendarApi = this.$refs.fullCalendar.getApi() // from the ref="..."
      calendarApi.gotoDate('2000-01-01') // call a method on the Calendar object
    },
    handleDateClick(arg) {
      if (confirm('Would you like to add an event to ' + arg.dateStr + ' ?')) {
        this.calendarEvents.push({ // add new event data
          title: 'New Event',
          start: arg.date,
          /* allDay: arg.allDay */
        })
      }
}
}
}
</script>

<style lang='scss'>
@import "~@fullcalendar/core/main.css";
@import "~@fullcalendar/timeline/main.css";
@import "~@fullcalendar/resource-timeline/main.css";

.fc-license-message {
  display: none;
}
.fc-divider.fc-col-resizer.fc-widget-header {
  height: auto;
}
.fc-scroller {
  height: auto !important;
}
.fc-timeline .fc-cell-text {
  color: #999;
  padding-right: 2px;
  font-size: 0.9em;
}
.fc-button-primary {
  color: #fff;
  background-color: #42b983 !important;
  border-color: #42b983 !important;
}
.ready {
  background-color: #42b983 !important;
}
.in work {
  background-color: rgb(88, 218, 156);
}
.abolition {
  background-color: rgb(255, 194, 10);
}
.not_verified {
  background-color: #ddd;
}
.fc-center {
  text-align: center;
}
.fc-button-primary:focus {
  border-bottom-width: 2px;
  background: hsla(0, 0%, 100%, 0.15);
  color: white;
  box-shadow: none;
}
.fc-event {
  border: none;
}
.fc-button-primary:not(:disabled):active:focus,
.fc-button-primary:not(:disabled).fc-button-active:focus {
  box-shadow: none;
}
.fc-toolbar.fc-header-toolbar {
  height: 50px;
  padding: 0 15px;
}
.fc-resourceTimelineDay-button {
  margin-right: 1px;
}
.fc-toolbar.fc-header-toolbar {
  margin-bottom: 0.5em;
}
.fc-button-primary:hover {
  border: 1px solid white !important;
  -webkit-transition: 0.1s;
  transition: 0.1s;
}
.fc-resourceTimelineDay-button,
.fc-resourceTimelineWeek-button {
  padding: 0.3em 1em;
  height: 2.2em;
  font-size: 1.2em;
}
.fc-highlight {
    background: #038eaa;
    opacity: .3;
}
.fc-center {
  display: flex;
  justify-content: center;
}
.fc-toolbar.fc-header-toolbar .fc-center h2 {
  font-size: 1.4em;
  line-height: 1.3;
  font-weight: 400;
  color: #ffffff;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
    "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji",
    "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
}
.fc-toolbar.fc-header-toolbar {
  background-color: #42b983;
}
.fc-timeline-event.fc-h-event.fc-event.fc-start.fc-end.fc-draggable {
  height: 33px;
}
.fc-time {
  position: relative;
}
.fc-event .fc-content {
  display: flex;
  height: 100%;
  align-items: center;
}
.fc-button-primary:focus {
  box-shadow: none;
}
.logo{
display: flex;
justify-content: flex-end;
height: 80px;
}
@media screen and (max-width: 600px){
  .fc-toolbar.fc-header-toolbar{
    
    padding: 0;
  }
body .fc {
    font-size: .7em;
}
.fc-toolbar.fc-header-toolbar {
    height: 60px;
}
.fc-toolbar > * > :not(:first-child) {
    margin-left: 1em;
}
}
</style>
