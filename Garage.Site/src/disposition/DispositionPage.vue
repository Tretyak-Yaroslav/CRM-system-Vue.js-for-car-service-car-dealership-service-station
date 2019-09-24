<template>
  <Disposition>
    <div style="margin:0px 10px;">
      <FullCalendar
        ref="fullcalendar"
        :plugins="calendarPlugins"
        defaultView="resourceTimelineDay"
        resourceLabelText=" "
        nowIndicator="true"
        timeZone="locale"
        :header="{
                        left: 'prev,next, today',
                        center: 'title',
                        right: 'resourceTimelineDay,resourceTimelineWeek'
                      }"
        displayEventTime="true"
        displayEventEnd="true"
        selectable="true"
        :eventTimeFormat="{
                        hour: '2-digit',
                        minute: '2-digit',
                        second: '2-digit',
                        meridiem: false
                      }"
        :resources="resources"
        :events="events"
        :allDay="true"
        :eventClick="true"
        :eventRender="eventRender"
        minTime="09:00:00"
        maxTime="21:00:00"
        @eventClick="eventClick"
        @dateClick="handleDateClick"
        @select="handleSelect"
      />
        <b-popover ref="refpopover" :target="tooltip.target" :key="tooltip.key" triggers="hover" placement="bottom" >
            <div v-html="tooltip.content"> </div>
        </b-popover> 
      <div id="forempty"> </div>

      <ul class="list-inline" style="margin-top:10px">
        <li  class="list-inline-item" v-bind:style="{background: item.color, padding: 5 +'px'}" v-for="item in masters" v-bind:key="item.id">{{item.text}} </li>
      </ul>
      <b-button v-b-modal.modal-center class="visibility">Open Modal</b-button>
      <b-modal id="modal-center" ref="modal" title="Заявка: НОВА">
        <div class="row">
          <div class="col-6 if-available left">
            <div class="form-group">
              <b-form-input
                placeholder="Введіть ім'я"
                required
                id="customerFullName"
                v-model="form.customerFullName"
              ></b-form-input>
            </div>
          </div>
          <div class="col-6 if-available right">
            <div class="form-group">
              <masked-input
                placeholder="Телефон"
                v-model="form.customerPhoneNumber"
                id="customerPhoneNumber"
                required
                type="text"
                name="phone"
                class="form-control"
                mask="\+\38 (111) 111-1111"
              />
            </div>
          </div>
          <div class="col-6 if-available left">
            <label class="control-label">Дата:</label>
            <b-form-input id="time" type="datetime" class="mr-b" v-model="form.DateTime"></b-form-input>
          </div>
          <div class="col-6 if-available left">
            <label class="control-label">Початок роботи</label>
            <b-form-input id="time" type="datetime" class="mr-b" v-model="form.startTime"></b-form-input>
          </div>
           <div class="col-6 if-available left">
            <label class="control-label">Початок роботи</label>
            <b-form-input id="time" type="datetime" class="mr-b" v-model="form.time"></b-form-input>
          </div>
          <div class="col-6 if-available right">
            <label class="control-label">Закінчення роботи</label>
            <b-form-input id="time" type="datetime" class="mr-b" v-model="form.endTime"></b-form-input>
          </div>
        </div>
        <b-form-group id="vendorName" label="Марка:" label-for="vendorName">
          <b-form-select
            id="vendorName"
            v-model="form.vendorName"
            :options="vendorNames"
            v-on:change="getSelectedBrand"
            required
          ></b-form-select>
        </b-form-group>
        <b-form-group id="vehicleModelName" label="Модель:" label-for="vehicleModelName">
          <b-form-select
            id="vehicleModelName"
            v-model="form.vehicleModelName"
            :options="vehicleModelNames"
            required
          ></b-form-select>
        </b-form-group>
        <b-form-group id="vehicleRegistrationNumber" label-for="vehicleRegistrationNumber">
          <b-form-input
            id="vehicleRegistrationNumber"
            v-model="form.vehicleRegistrationNumber"
            required
            placeholder="Введіть номер автомобіля"
          ></b-form-input>
        </b-form-group>
        <div class="form-group">
          <label class="control-label">Пост:</label>
          <b-form-select
            id="workplace"
            v-modal="form.workplace"
            :options="workplaces"
            v-on:change="changeWorkPlace"
          ></b-form-select>
        </div>
        <b-form-group id="itemCategory" label="Послуга:" label-for="itemCategory">
          <b-form-select
            id="itemCategory"
            v-model="form.itemCategory"
            :options="itemCategorys"
            required
          ></b-form-select>
        </b-form-group>
        <div class="form-group">
          <label class="control-label">Мастер-приймальник</label>
          <b-form-select id="master" v-model="form.master" :options="masters" required></b-form-select>
        </div>
        <div class="form-group">
          <label class="control-label">Механік</label>
          <b-form-select id="mechanic" v-model="form.mechanic" :options="mechanics" required></b-form-select>
        </div>
        <b-form-textarea
          id="queryDescription"
          v-model="form.QueryDescription"
          placeholder="Коментар"
          rows="2"
          max-rows="2"
        ></b-form-textarea>
        <b-row class="mt-1">
          <b-col sm="7" md="7" offset-md="0" class="d-flex justify-content-end p-0">
            <b-button @click="$bvModal.hide('modal-center')">ЗАКРИТИ</b-button>
          </b-col>
          <b-col class="d-flex justify-content-end">
            <b-button class="ml-auto pr-5 pl-5" variant="primary " @click="saveQuery">ЗБЕРЕГТИ</b-button>
          </b-col>
        </b-row>
      </b-modal>
      <!-- Short statement selection - working version -->
      <b-modal id="modal-editing" ref="modal" title="Редагування заявки:">
        <div class="row">
          <div class="col-6 if-available left">
            <div class="form-group">
              <label class="control-label">Статус</label>
              <b-form-select
                id="master"
                v-model="form.queryStatusName"
                :options="queryStatusNames"
                required
              ></b-form-select>
            </div>
          </div>
          <div class="col-6 if-available right">
            <div class="form-group">
              <label class="control-label">Підйомник</label>
              <b-form-select
                id="workplace"
                v-model="form.workplaceChange"
                :options="workplaces"
                required
              ></b-form-select>
            </div>
          </div>
        </div>
        <div class="form-group">
          <label class="control-label">Мастер</label>
          <b-form-select id="master" v-model="form.masterChange" :options="masters" required></b-form-select>
        </div>
        <div class="form-group">
          <label class="control-label">Механік</label>
          <b-form-select id="mechanic" v-model="form.mechanicChange" :options="mechanics" required></b-form-select>
        </div>
        <b-form-group
          id="vehicleRegistrationNumber"
          label="Номер автомобіля:"
          label-for="vehicleRegistrationNumber"
        >
          <b-form-input
            id="vehicleRegistrationNumber"
            v-model="form.vehicleRegistrationNumberChange"
            required
            placeholder="Введіть номер автомобіля"
          ></b-form-input>
        </b-form-group>
        <div class="form-group">
          <label class="control-label">Послуга</label>
          <b-form-select
            id="itemCategory"
            v-model="form.itemCategoryChange"
            :options="itemCategorys"
            required
          ></b-form-select>
        </div>
        <div class="row">
          <div class="col-6 if-available left">
            <div class="form-group">
              <label class="control-label">Ім'я:</label>
              <b-form-input
                placeholder="Введіть ім'я"
                required
                id="customerFullName"
                v-model="form.customerFullNameChange"
              ></b-form-input>
            </div>
          </div>
          <div class="col-6 if-available right">
            <div class="form-group">
              <label class="control-label">Телефон</label>
              <masked-input
                v-model="form.customerPhoneNumberChange"
                id="customerPhoneNumber"
                required
                type="text"
                name="phone"
                class="form-control"
                mask="\+\38 (111) 111-1111"
              />
            </div>
          </div>
          <div class="col-6 if-available left">
            <label class="control-label">Початок роботи</label>
            <b-form-input id="time" type="datetime" class="mr-b" v-model="form.startTimeChange"></b-form-input>
          </div>
          <div class="col-6 if-available right">
            <label class="control-label">Закінчення роботи</label>
            <b-form-input id="time" type="datetime" class="mr-b" v-model="form.endTimeChange"></b-form-input>
          </div>
        </div>
        <b-form-textarea
          id="queryDescription"
          v-model="form.queryDescriptionChange"
          placeholder="Коментар"
        ></b-form-textarea>
        <b-button class="mt-3" variant="outline-success" block @click="changeQuery">Зберегти зміни</b-button>
      </b-modal>

      <DetailsTable></DetailsTable>
    </div>
  </Disposition>
</template>
<script charset="utf-8">
import FullCalendar from "@fullcalendar/vue";
import resourceTimelinePlugin from "@fullcalendar/resource-timeline";
import interactionPlugin from "@fullcalendar/interaction";
import timeGridPlugin from "@fullcalendar/timegrid";
import MaskedInput from "vue-masked-input";
import axios from "axios";
import DetailsTable from "../TableDetails/DetailsTable";
import moment from "moment";
import "moment/locale/uk";
export default {
  created() {
    var date1 = new Date();
    date1.setDate(date1.getDate() - 3);
    var date2 = new Date();
    date2.setDate(date2.getDate() + 3);
    this.$store.dispatch("getQueryStatus", { params: { id: 0 } }).then(res => {
      var statusData = JSON.parse(JSON.stringify(res.data));
      this.queryStatusNames = statusData.map(function(i) {
        return {
          text: i["queryStatusName"],
          value: i["queryStatusID"]
        };
      });
    });
    this.$store.dispatch("getWorkPlace", { params: { id: 1 } }).then(res => {
      var resourcesData = JSON.parse(JSON.stringify(res.data));
      this.resources = resourcesData.map(function(i) {
        return {
          id: i["workPlaceID"],
          title: i["workPlaceName"]
        };
      });
    });
    this.$store.dispatch("getWorkPlace", { params: { id: 1 } }).then(res => {
      var workplaceData = JSON.parse(JSON.stringify(res.data));
      this.workplaces = workplaceData.map(function(i) {
        return {
          value: i["workPlaceID"],
          text: i["workPlaceName"]
        };
      });
    });
    this.$store
      .dispatch("getEmployees", {
        params: { workShopID: 1, employeePostID: 1 }
      })
      .then(res => {
        var vendorsData = JSON.parse(JSON.stringify(res.data));
        this.masters = vendorsData.map(function(i) {
          return {
            text: i["employeeFirstName"] + " " + i["employeeLastName"],
            value: i["employeeID"],
            color: i["employeeColor"]
          };
        });
      });
    this.$store
      .dispatch("getEmployees", {
        params: { workShopID: 1, employeePostID: 2 }
      })
      .then(res => {
        var mechanicData = JSON.parse(JSON.stringify(res.data));
        this.mechanics = mechanicData.map(function(i) {
          return {
            text: i["employeeFirstName"] + " " + i["employeeLastName"],
            value: i["employeeID"]
          };
        });
      });
    this.$store.dispatch("getItem", { params: { id: 0 } }).then(res => {
      var vendorsData = JSON.parse(JSON.stringify(res.data));
      this.itemCategorys = vendorsData.map(function(i) {
        return {
          text: i["itemName"],
          value: i["itemID"]
        };
      });
    });
    this.$store.dispatch("getVendor", { params: { id: 0 } }).then(res => {
      var vendorsData = JSON.parse(JSON.stringify(res.data));
      this.vendorNames = vendorsData.map(function(i) {
        return {
          text: i["vendorName"],
          value: i["vendorID"]
        };
      });
    });
    this.$store.dispatch("getItem", { params: { id: 0 } }).then(res => {
      var vendorsData = JSON.parse(JSON.stringify(res.data));
      this.itemCategorys = vendorsData.map(function(i) {
        return {
          text: i["itemName"],
          value: i["itemID"]
        };
      });
    });
    this.getEvents();
  },
  components: {
    FullCalendar,
    MaskedInput,
    DetailsTable
  },
  data() {
    return {
      querystatus: {
        workShopID: "",
        queryStatusID: "",
        notShortQuery: "",
        phone: "",
        employeeMasterColor: "",
        queryStatusColor: ""
      },
      form: {
        master: "",
        mechanic: "",
        employes: "",
        status: "",
        queryStatusName: "",
        itemCategory: "",
        customerFullName: "",
        customerPhoneNumber: "",
        queryDescription: "",
        workplace: "",
        startTime: "",
        endTime: "",
        time:"",
        vehicleModelName: "",
        vehicleRegistrationNumber: "",
        vendorName: "",
        itemCategoryChange: "",
        customerFullNameChange: "",
        customerPhoneNumberChange: "",
        queryDescriptionChange: "",
        masterChange: "",
        startTimeChange: "",
        endTimeChange: "",
        mechanicChange: "",
        queryStatusNameChange: "",
        workplaceChange: "",
        vendorNameChange: "",
        vehicleModelNameChange: "",
        vehicleRegistrationNumberChange: "",
        id: "",
        DateTime: "",
        vehicleID: "",
        customerID: ""
      },
      calendarPlugins: [
        resourceTimelinePlugin,
        timeGridPlugin,
        interactionPlugin
      ],
      selectable: true,
      calendarEvents: [{ title: "Event Now", start: new Date() }],
      resources: [],
      workplaces: [],
      employes: [],
      queryStatusNames: [],
      vehicleModelNames: [],
      vendorNames: [],
      itemCategorys: [],
      masters: [],
      mechanics: [],
      requestStatus: [],
      events: [],
      itemCategorys: [],
      querys: [],
      queryNumbers: [],
      currentQuery: [],
      tooltip: {target:'forempty', content : '', key : 0}
    };
  },
  handleSelect(arg) {
    this.form.startTime = arg.startStr;
    var handleStart = new Date(this.form.startTime);
    this.form.endTime = arg.endStr;
    var formated_handleStart =
      (handleStart.getHours() < 10 ? "0" : "") +
      handleStart.getHours() +
      ":" +
      (handleStart.getMinutes() < 10 ? "0" : "") +
      handleStart.getMinutes();

    this.form.startTime = formated_handleStart;
    var handleEnd = new Date(this.form.endTime);
    var formated_handleEnd =
      (handleEnd.getHours() < 10 ? "0" : "") +
      handleEnd.getHours() +
      ":" +
      (handleEnd.getMinutes() < 10 ? "0" : "") +
      handleEnd.getMinutes();
    this.form.endTime = formated_handleEnd;
    this.$bvModal.show("modal-center");
  },
  methods: {
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
    changeQueryStatusName(id) {
      this.form.queryStatusName = id;
      this.updateQueryListByQueryType(id);
    },
    updateQueryListByQueryType(id) {
      var date1 = new Date();
      date1.setDate(date1.getDate() - 3);

      var date2 = new Date();
      date2.setDate(date2.getDate() + 3);

      this.$store
        .dispatch("postQuery", {
          params: {
            from: date1.toISOString().slice(0, 10),
            to: date2.toISOString().slice(0, 10),
            workShopID: 1,
            queryStatusID: id,
            notShortQuery: 0
          }
        })
        .then(res => {
          var statusData = JSON.parse(JSON.stringify(res.data));
          this.querys = statusData;
          this.requestStatus = statusData.map(function(i) {
            return {
              text: i["queryID"],
              value: i["queryID"]
            };
          });
        });
    },
    handleSelect(arg) {
      this.form.startTime = arg.startStr;
    
      var handleStart = new Date(this.form.startTime);
      this.form.endTime = arg.endStr;
      var formated_handleStart =
        (handleStart.getHours() < 10 ? "0" : "") +
        handleStart.getHours() +
        ":" +
        (handleStart.getMinutes() < 10 ? "0" : "") +
        handleStart.getMinutes();
      this.form.startTime = formated_handleStart;
      var handleEnd = new Date(this.form.endTime);
      var formated_handleEnd =
        (handleEnd.getHours() < 10 ? "0" : "") +
        handleEnd.getHours() +
        ":" +
        (handleEnd.getMinutes() < 10 ? "0" : "") +
        handleEnd.getMinutes();
      this.form.endTime = formated_handleEnd;
      this.$bvModal.show("modal-center");
    },

    handleDateClick(arg) {
      this.form.startTime = arg.dateStr;
      var startDate = new Date(this.form.startTime);
      var endDate = new Date(this.form.startTime);
      endDate.setMinutes(endDate.getMinutes() + 60);
      var formatted_date1 =
        (startDate.getHours() < 10 ? "0" : "") +
        startDate.getHours() +
        ":" +
        (startDate.getMinutes() < 10 ? "0" : "") +
        startDate.getMinutes();
          this.form.startTime = formatted_date1;
    /*   this.form.time = formatted_date1;

      var formatted_dateTime =
       dateTime.getFullYear() +
        "-" +
        ((dateTime.getMonth() + 1 )< 10 ? "0" : "")  +
        (dateTime.getMonth() + 1) +
        "-" +
        (dateTime.getDate() < 10 ? "0" : "") +
        dateTime.getDate() 
        ;
      this.form.DateTime = formatted_dateTime;

var date = formatted_dateTime ;
var time = formatted_date1;

var dateTime = moment(date + ' ' + time, 'YYYY-MM-DDTHH:mm:ssZ');

console.log(dateTime.format('YYYY-MM-DDTHH:mm:ssZ'))    */   
/* momet(dateTime).format();
console.log(dateTime); */
       /* this.form.startTime =  function(datetime){
       
        formatted_dateTime.getUTCFullYear(),
        formatted_dateTime.getUTCMonth(),
        formatted_dateTime.getUTCDate(),
        formatted_date1.getUTCHours(),
        formatted_date1.getUTCMinutes(),
        formatted_date1.getUTCSeconds()
      
       console.log(datetime)
        return{
        startTime:i["datetime"]
      }
      console.log(datetime)
      }  */
       /* var datetime = new Date(this.form.startTime);
 */
/* var date = new Date(this.form.startTime); 
var now_utc =  Date.UTC(formatted_dateTime.getUTCFullYear(), formatted_dateTime.getUTCMonth(), formatted_dateTime.getUTCDate(),
 formatted_date1.getUTCHours(), formatted_date1.getUTCMinutes(), formatted_date1.getUTCSeconds());

 return new Date(now_utc);
 console.log(now_utc);
 */
/*  Date.prototype.toISOString = function(newdate) {
      return formatted_dateTime.getUTCFullYear()
        + '-' + pad( formatted_dateTime.getUTCMonth() + 1 )
        + '-' + pad( formatted_dateTime.getUTCDate() )
        + 'T' + pad( formatted_date1.getUTCHours() )
        + ':' + pad( formatted_date1.getUTCMinutes() )
        + ':' + pad( formatted_date1.getUTCSeconds() )
        + '.' + String( (formatted_date1.getUTCMilliseconds()/1000).toFixed(3) ).slice( 2, 5 )
        + 'Z';
    };
    console.log(newdate); */
 /*     Date.prototype.toISOString = function(newdate) {
      return this.getUTCFullYear()
        + '-' + formatted_dateTime( this.getUTCMonth() + 1 )
        + '-' + formatted_dateTime( this.getUTCDate() )
        + 'T' + formatted_dateTime( this.getUTCHours() )
        + ':' + formatted_date1( this.getUTCMinutes() )
        + ':' + formatted_date1( this.getUTCSeconds() )
        + '.' + String( (this.getUTCMilliseconds()/1000).toFixed(3) ).slice( 2, 5 )
        + 'Z';
    };
     console.log(newdate); */
/* let initialdate = '2016-10-01';
let start_time = '19:04:10';
let enddate = '2016-10-01';
let end_time = '19:04:20';

let datetimeA = moment(initialdate + " " + start_time);
let datetimeB = moment(enddate + " " + end_time);

console.log(datetimeA.format());
console.log(datetimeB.format());

let datetimeC = datetimeB.diff(datetimeA, 'seconds');
 */
/* console.log(datetimeC);     
var date = moment(  startDate.getUTCFullYear()
        + '-' + startDate.getUTCMonth()
        + '-' + startDate.getUTCDate() 
        + 'T' + startDate.getUTCHours() 
        + ':' + startDate.getUTCMinutes() 
        + ':' + startDate.getUTCSeconds());
var data = date._i;
console.log(data);
this.date = new Date();
var event = new Date(data);

console.log(event.toUTCString());
var jsonDate = event.toJSON();

var data = new Date(this.form.startTime); */
// expected output: 1975-08-19T23:15:30.000Z
/* console.log(new Date(jsonDate).toUTCString());
 */// expected output: Tue, 19 Aug 1975 23:15:30 GMT

/* var date = new Date();
date.toISOString(); 
console.log(date); */
/* function myFunction() {
  var d = Date.parse(date._i);
 console.log(d);
} */
/*  (data.Now.ToString("dd'/'M'/'yyyy"))
 format: "dd/MM/yyyy"
moment.utc(data).format('LTS');


moment(String(data)).format("YYYY-MM-DDTHH:mm:ss");  */
/* function (timechange){
var time =new Date (DateTimeConcat);
time.setUTCHours(0);
var output = timechange.toISOString(time, {zulu: true}) ;
    output += timechange.toISOString(time, {selector: 'date'});
    output += timechange.fromISOString("2008-10-17T00:00:00Z").toGMTString()
} */
/* moment(String( DateTimeConcat)).format();
console.log(DateTimeConcat);  */
/* var time =new Date (DateTimeConcat);
console.log(time.toISOString());
console.log(DateTimeConcat); 
var isoDate = new Date('DateTimeConcat').toISOString();
console.log(isoDate); */

      var formatted_date =
        (endDate.getHours() < 10 ? "0" : "") +
        endDate.getHours() +
        ":" +
        (endDate.getMinutes() < 10 ? "0" : "") +
        endDate.getMinutes();
      this.form.endTime = formatted_date;
      this.$bvModal.show("modal-center");
    },
    eventRender(arg) {
      var elid = arg.el.id = 'event'+arg.event.id;
      arg.el.addEventListener("mouseenter",(evt) =>  this.mouseEnterEvent(elid, arg.event));
    },
    eventClick(arg) {
      var id = arg.event._def.publicId;
      var date1 = new Date();
      date1.setDate(date1.getDate() - 3);
      var date2 = new Date();
      date2.setDate(date2.getDate() + 3);
      this.$store
        .dispatch("postQuery", {
          params: {
            from: date1.toISOString().slice(0, 10),
            to: date2.toISOString().slice(0, 10),
            workShopID: 1,
            queryStatusID: 0,
            notShortQuery: 0,
            queryID: id
          }
        })
        .then(res => {
          var queryData = JSON.parse(JSON.stringify(res.data));
          this.queryNumbers = queryData;
          for (var i = 0; i < this.queryNumbers.length; i++) {
            if (this.queryNumbers[i].queryID == id) {
              this.currentQuery = this.queryNumbers[i];
              this.form.id = id;
              this.form.itemCategoryChange = this.queryNumbers[i].itemID;
              this.form.customerFullNameChange = this.queryNumbers[i].customerFullName;
              this.form.customerPhoneNumberChange = this.queryNumbers[i].customerPhoneNumber;
              this.form.queryDescriptionChange = this.queryNumbers[i].queryDescription;
              this.form.workplaceChange = this.queryNumbers[i].workPlaceID;
              this.form.masterChange = this.queryNumbers[i].employeeMasterID;
              var handleStart = new Date(this.queryNumbers[i].startTime);
              var formated_handleStart =
                (handleStart.getHours() < 10 ? "0" : "") +
                handleStart.getHours() +
                ":" +
                (handleStart.getMinutes() < 10 ? "0" : "") +
                handleStart.getMinutes();
              this.form.startTimeChange = formated_handleStart;
              var handleEnd = new Date(this.queryNumbers[i].endTime);
              handleEnd.setMinutes(handleEnd.getMinutes() + 60);
              var handleEnd = new Date(this.queryNumbers[i].endTime);
              var formated_handleEnd =
                (handleEnd.getHours() < 10 ? "0" : "") +
                handleEnd.getHours() +
                ":" +
                (handleEnd.getMinutes() < 10 ? "0" : "") +
                handleEnd.getMinutes();
              this.form.endTimeChange = formated_handleEnd;
              this.form.mechanicChange = this.queryNumbers[i].employeeID;
              this.form.queryStatusName = this.queryNumbers[i].queryStatusID;
              this.form.vendorNameChange = this.queryNumbers[i].vendorID;
              this.form.vehicleModelNameChange = this.queryNumbers[i].vehicleModelID;
              this.form.vehicleRegistrationNumberChange = this.queryNumbers[i].vehicleRegistrationNumber;
              this.form.customerID = this.queryNumbers[i].customerID;
              this.form.vehicleID = this.queryNumbers[i].vehicleID;
            }
          }
          this.queryNumber = queryData.map(function(i) {
            return {
              queryID: i["queryID"]
            };
          });
        });
      this.$bvModal.show("modal-editing");
      this.tooltip.key++;
      this.tooltip.target = 'forempty';
    },

    changeQuery(evt) {
      for (var i = 0; i < this.queryNumbers.length; i++) {
        if (this.queryNumbers[i].queryID == this.form.id) {
        }
      }
      this.$store
        .dispatch("setQuery", {
          params: {
            queryID: this.form.id,
            workShopID: 1,
            customerFullName: this.form.customerFullNameChange,
            customerPhoneNumber: this.form.customerPhoneNumberChange,
            itemID: this.form.itemCategoryChange,
            queryDescription: this.form.queryDescriptionChange,
            vehicleModelID: this.form.vehicleModelNameChange,
            vehicleModificationID: this.form.vehicleModelNameChange,
            vehicleRegistrationNumber: this.form.vehicleRegistrationNumberChange,
            employeeID: this.form.mechanicChange,
            employeeMasterID: this.form.masterChange,
            workPlaceID: this.form.workplaceChange,
            startTime: this.form.startTimeChange,
            endTime: this.form.endTimeChange,
            queryStatusID: this.form.queryStatusName,
            vendorID: this.form.vendorNameChange,
            customerID: this.form.customerID,
            vehicleID: this.form.vehicleID
          }
        })
        .then(res => {
          this.$bvModal.hide("modal-editing");
          this.getEvents();
        });
    },
    changeWorkPlace(id) {
      this.form.workplace = id;
    },
    saveQuery() {
      var queryId = this.form.querystatus;
      var vehicleModelID = this.currentQuery.vehicleModelID;
      if (!vehicleModelID) {
        vehicleModelID = 1;
      }
      var vehicleModificationID = this.currentQuery.vehicleModificationID;
      if (!vehicleModificationID) {
        vehicleModificationID = 1;
      }
     
      this.$store
        .dispatch("setQuery", {
          params: {
            queryID: 0,
            workShopID: 1,
            customerFullName: this.form.customerFullName,
            customerPhoneNumber: this.form.customerPhoneNumber,
            itemID: this.form.itemCategory,
            queryDescription: this.form.queryDescription,
            vehicleModelID: this.form.vehicleModelName,
            vehicleModificationID: this.form.vehicleModelName,
            vehicleRegistrationNumber: this.form.vehicleRegistrationNumber,
            employeeID: this.form.mechanic,
            employeeMasterID: this.form.master,
            workPlaceID: this.form.workplace,
            startTime: this.form.startTime,
            endTime: this.form.endTime,
            queryStatusID: 2,
            //vendorID: this.form.vendorName
            customerID: 0,
            vehicleID: 0
          }
        })
        .then(res => {
          this.$bvModal.hide("modal-center");
          this.getEvents();
        });
    },
    getSelectedBrand(id) {
      this.$store
        .dispatch("getVehicleModel", { params: { id: id } })
        .then(res => {
          var vendorsData = JSON.parse(JSON.stringify(res.data));
          this.vehicleModelNames = vendorsData.map(function(i) {
            return {
              text: i["vehicleModelName"],
              value: i["vehicleModelID"]
            };
          });
        });
    },
    getEvents(){

          var date1 = new Date();
    date1.setDate(date1.getDate() - 3);
    var date2 = new Date();
    date2.setDate(date2.getDate() + 3);

          this.$store
      .dispatch("getQuery", {
        params: {
          from: date1.toISOString().slice(0, 10),
          to: date2.toISOString().slice(0, 10),
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
    }
  }
};
</script>
<style lang='scss'>
@import "~@fullcalendar/core/main.css";
@import "~@fullcalendar/timeline/main.css";
@import "~@fullcalendar/resource-timeline/main.css";
.fc-license-message {
  display: none;
}
.fc-timeline-event.fc-h-event.fc-event.fc-start.fc-end.fc-draggable {
  border: 2px solid;
}
.fc-resource-area.fc-widget-header {
  width: 150px !important;
}
.fc-cell-content {
  text-align: center;
}
form {
  padding: 15px;
  background-color: #fff;
  background-clip: padding-box;
  border: 1px solid #999;
  border: 1px solid rgba(0, 0, 0, 0.2);
  border-radius: 6px;
  -webkit-box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
  box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
  outline: 0;
}
.submit_bt {
  display: flex;
  justify-content: flex-end;
  margin-top: 10px;
}
textarea #queryDescription {
  overflow-y: auto;
}
.form-group {
  margin-bottom: 0.5rem !important;
}
@media screen and (max-width: 600px) {
  .form-group {
    margin-bottom: 0.3rem;
  }
  label {
    margin-bottom: 0.2rem;
  }
}
.btn.btn-success[data-v-44a775b7] {
  float: right;
  margin-top: 10px;
}
.visibility {
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
.mr-b {
  margin-bottom: 15px;
}
.fc-button-primary:hover {
  border: 1px solid white !important;
  -webkit-transition: 0.1s;
  transition: 0.1s;
}
button.visibility {
  display: none;
}
.fc-event-container {
  height: 80% !important ;
}
.fc-timeline-event.fc-h-event.fc-event.fc-start.fc-end.fc-draggable {
  height: 91% !important;
}
.fc-time {
  display: none;
}
.fc-resourceTimelineDay-button,
.fc-resourceTimelineWeek-button {
  padding: 0.3em 1em;
  height: 2.2em;
  font-size: 1.2em;
}
.modal-footer {
  display: none !important;
}
.fc-highlight {
  background: #038eaa;
  opacity: 0.3;
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
.logo {
  display: flex;
  padding: 5px;
}

.fc-toolbar.fc-header-toolbar .fc-center h2 {
  font-size: 1.4em !important;
}
@media screen and (max-width: 600px) {
  .fc-toolbar.fc-header-toolbar {
    padding: 0;
  }
  body .fc {
    font-size: 0.7em;
  }
  .fc-toolbar.fc-header-toolbar {
    height: 60px;
  }
  .fc-toolbar > * > :not(:first-child) {
    margin-left: 1em;
  }
}
@media screen and (min-width: 575px) {
  .col-sm-2 .col-md-1 {
    width: auto !important;
  }
}
</style>