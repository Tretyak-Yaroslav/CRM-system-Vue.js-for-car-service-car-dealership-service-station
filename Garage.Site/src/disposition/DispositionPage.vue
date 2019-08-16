<template>
  <div style="margin:0px 10px;">
    <b-container fluid>
      <b-row>
    <b-col class="logo " md="1">
      <img src="../../src/assets/logo_ad.png" alt="logo" />
    </b-col>
    <b-col md="10" class="d-flex justify-content-center"><h2>Garage</h2></b-col>
     
      <b-col md="1"> <button v-on:click="logout" id="logout" class="btn btn-primary">Вихід</button></b-col>
      </b-row>
  </b-container>
    <FullCalendar
      :plugins="calendarPlugins"
      defaultView="resourceTimelineDay"
      locale="uk"
      nowIndicator="true"
      timeZone="locale"
      :header="{
                        left: 'prev,next today',
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
      :allDay= "false"
    
      @dateClick="handleDateClick"
      @select="handleSelect" 
    />

    <b-button v-b-modal.modal-center class="visibility">Open Modal</b-button>
    <b-modal id="modal-center" ref="modal" title="Створення заявки :">
        <!-- <b-form-group id="customerPhoneNumber" label="Телефон:" label-for="phone">
          <b-form-input
            id="customerPhoneNumber"
            v-model="form.customerPhoneNumber"
            required
            placeholder="+3809605478377"
          ></b-form-input>
        </b-form-group>

        <b-form-group id="customerFullName" label="Ім'я:" label-for="name">
          <b-form-input
            id="customerFullName"
            v-model="form.customerFullName"
            required
            placeholder="Введіть ім'я"
          ></b-form-input>
        </b-form-group> -->

      <div class="row">
        <div class="col-6 if-available left">
          <div class="form-group">
            <label class="control-label">Ім'я:</label>
            <b-form-input id="customerFullName" v-model="form.customerFullName"></b-form-input>
          </div>
        </div>
        <div class="col-6 if-available right">
          <div class="form-group">
            <label class="control-label">Телефон</label>
            <b-form-input id="customerPhoneNumber" v-model="form.customerPhoneNumber"></b-form-input>
          </div>
        </div>
      <div class="col-6 if-available left">
          <label class="control-label">Початок роботи</label>
          <b-form-input type="datetime" class="mr-b" v-model="form.startTime" format="yyyy-MM-dd HH:mm:ss"></b-form-input>
        </div>
        <div class="col-6 if-available right">
          <label class="control-label">Закінчення роботи</label>
          <b-form-input type="datetime" class="mr-b" v-model="form.endTime" format="yyyy-MM-dd HH:mm:ss"></b-form-input>
           
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
        <b-form-group id="vehicleRegistrationNumber" label="Номер автомобіля:" label-for="vehicleRegistrationNumber">
          <b-form-input
            id="vehicleRegistrationNumber"
            v-model="form.vehicleRegistrationNumber"
            required
            placeholder="Введіть номер автомобіля"
          ></b-form-input>
        </b-form-group>
 <div class="form-group">
        <label class="control-label">Підйомник:</label>
        <b-form-select
          id="workplace"
          v-modal="form.workplace"
          :options="workplaces"
          v-on:change="changeWorkPlace"
        ></b-form-select>
      </div>
      <div class="form-group">
        <label class="control-label">Мастер</label>
        <b-form-select id="master"
         v-model="form.master" 
         :options="masters" 
         required>
         </b-form-select>
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
        <b-form-group id="itemCategory" label="Послуга:" label-for="itemCategory">
          <b-form-select
            id="itemCategory"
            v-model="form.itemCategory"
            :options="itemCategorys"
            required
          ></b-form-select>
        </b-form-group>

        <b-form-textarea
          id="orderDescription"
          v-model="form.orderDescription"
          placeholder="Коментар"
          rows="2"
          max-rows="2"
         
        ></b-form-textarea>

        <!--<pre class="mt-3 mb-0">{{ text }}</pre>-->
        <!-- <b-col class="submit_bt">
          <b-button type="submit" variant="success">Cтворити заявку</b-button>
        </b-col> -->
      <b-button class="mt-3" variant="success" block @click="saveOrder">Cтворити заявку</b-button>

     <!-- Short statement selection - working version -->
      <!-- <div class="form-group">
        <label class="control-label">Статус</label>
        <b-form-select
          id="orderStatusName"
          v-modal="form.orderStatusName"
          :options="orderStatusNames"
          v-on:change="changeOrderStatusName"
        ></b-form-select>
      </div>
      <div class="form-group">
        <label class="control-label">Перелік заявок:</label>
        <b-form-select
          id="status"
          v-modal="form.orderstatus"
          :options="requestStatus"
          v-on:change="changeOrder"
        ></b-form-select>
      </div>
      <div class="form-group">
        <label class="control-label">Підйомник:</label>
        <b-form-select
          id="workplace"
          v-modal="form.workplace"
          :options="workplaces"
          v-on:change="changeWorkPlace"
        ></b-form-select>
      </div>
      <div class="form-group">
        <label class="control-label">Мастер</label>
        <b-form-select id="master"
         v-model="form.master" 
         :options="masters" 
         required>
         </b-form-select>
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
        <b-form-select
          id="itemCategory"
          v-model="form.itemCategory"
          :options="itemCategorys"
          required
        ></b-form-select>
      </div>
      <div class="row">
        <div class="col-6 if-available left">
          <div class="form-group">
            <label class="control-label">Ім'я:</label>
            <b-form-input id="customerFullName" v-model="form.customerFullName"></b-form-input>
          </div>
        </div>
        <div class="col-6 if-available right">
          <div class="form-group">
            <label class="control-label">Телефон</label>
            <b-form-input id="customerPhoneNumber" v-model="form.customerPhoneNumber"></b-form-input>
          </div>
        </div>
      <div class="col-6 if-available left">
          <label class="control-label">Початок роботи</label>
          <b-form-input type="datetime" class="mr-b" v-model="form.startTime" format="yyyy-MM-dd HH:mm:ss"></b-form-input>
        </div>
        <div class="col-6 if-available right">
          <label class="control-label">Закінчення роботи</label>
          <b-form-input type="datetime" class="mr-b" v-model="form.endTime" format="yyyy-MM-dd HH:mm:ss"></b-form-input>
           
        </div>
      </div> 
   
      <b-form-textarea id="orderDescription" v-model="form.orderDescription" placeholder="Коментар"></b-form-textarea>

      <b-button class="mt-3" variant="outline-danger" block @click="saveOrder">Save</b-button>
     -->
     
    </b-modal>
  
  </div>
  
</template>

<script charset="utf-8">
import FullCalendar from "@fullcalendar/vue";
import resourceTimelinePlugin from "@fullcalendar/resource-timeline";
import interactionPlugin from "@fullcalendar/interaction";
import timeGridPlugin from "@fullcalendar/timegrid";
import Detailtable from '@/TableDetails/DetailsTable';
/* var calendar = new FullCalendar(FullCalendar, {
  events: [
    {
      title:  'My Event',
      start:  '2010-01-01T14:30:00',
      allDay: false
    }
    // other events here...
  ],
  eventTimeFormat: { // like '14:30:00'
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit'
  }
}); */
export default {
  created() {
//<<<<<<< HEAD
        const token = 'Bearer ' + localStorage.getItem('currentUser')
        if (token) {
          axios.defaults.headers.common['Authorization'] =  token
            //return router.push('/disposition');
        }    
//=======
    var date1 = new Date();
    date1.setDate(date1.getDate() -3);

    var date2 = new Date();
    date2.setDate(date2.getDate() + 3);

    console.log('Date1: ' + date1.toISOString().slice(0,10));
    console.log('Date2: ' + date2.toISOString().slice(0,10));
//>>>>>>> 0e0e15d81e933c6e8aeabf0ffdf0ebf94863045a
    this.$store.dispatch("getOrderStatus", { params: { id: 0 } }).then(res => {
      var statusData = JSON.parse(JSON.stringify(res.data));
      this.orderStatusNames = statusData.map(function(i) {
        return {
          text: i["orderStatusName"],
          value: i["orderStatusID"]
        };
      });
    });
    //this.updateOrderListByOrderType(0);

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
      console.log(this.workplaces);
    });
    this.$store
      .dispatch("getEmployees", {
        params: { workShopID: 1, employeePostID: 1 }
      })
      .then(res => {
        var vendorsData = JSON.parse(JSON.stringify(res.data));
        this.masters = vendorsData.map(function(i) {
          return {
            text: i["employeeFirstName"] + i["employeeLastName"],
            value: i["employeeID"]
          };
        });
      });

    this.$store.dispatch("getEmployees", {params: { workShopID: 1, employeePostID: 2 }}).then(res => {
        var mechanicData = JSON.parse(JSON.stringify(res.data));
        this.mechanics = mechanicData.map(function(i) {
          return {
            text: i["employeeFirstName"] + i["employeeLastName"],
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
    this.$store
      .dispatch("getOrder", {
        params: {
          from: date1.toISOString().slice(0,10),
          to: date2.toISOString().slice(0,10),
          workShopID: 1,
          orderStatusID: 0,
          notShortOrder: 0
        }
      })
      .then(res => {
        var eventsData = JSON.parse(JSON.stringify(res.data));
        console.log(eventsData);
        this.events = eventsData.map(function(i) {
          return {
            id: i["orderID"],
            resourceId: i["workPlaceID"],
            title: i["vendorName"]+ i["vehicleModelName"] + i["vehicleRegistrationNumber"] ,
            date: i["startTime"],
            end: i["endTime"],
            textColor: "white",
            class: "in_work",
            backgroundColor: i["calendarPluginsCode"]
          };
        });
      });
  },
  components: {
    FullCalendar,
    Detailtable
  },
  
  data() {
    return {
      orderstatus: {
        workShopID: "",
        orderStatusID: "",
        notShortOrder: "",
        Detailtable:""
      },
      form: {
        master: "",
        mechanic: "",
        employes: "",
        status: "",
        orderstatus: "",
        orderStatusName: "",
        itemCategory: "",
        customerFullName: "",
        customerPhoneNumber: "",
        orderDescription: "",
        workplace: "",
        startTime: "",
        endTime: "",
        customerFullName: "",
        vehicleModelName: "",
        vehicleRegistrationNumber: "",
        vendorName: "",
        orderDescription: ""
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
      orderStatusNames: [],
       vehicleModelNames: [],
      vendorNames: [],
      itemCategorys: [],
      masters: [],
      mechanics: [],
      requestStatus: [],
      events: [],
      itemCategorys: [],
      orders: [],
      currentOrder: ""
    };
  },

  methods: {
    logout(){
      localStorage.removeItem('currentUser');
      delete axios.defaults.headers.common['Authorization']
      this.$router.push('/')
    },
    changeOrderStatusName(id) {
      this.form.orderStatusName = id;
      console.log(id);
      this.updateOrderListByOrderType(id);
    },
    updateOrderListByOrderType(id) {
      var date1 = new Date();
      date1.setDate(date1.getDate() - 30);

      var date2 = new Date();
      date2.setDate(date2.getDate() + 3);

      this.$store
        .dispatch("postOrder", {
          params: {
            from: date1.toISOString().slice(0, 10),
            to: date2.toISOString().slice(0, 10),
            workShopID: 1,
            orderStatusID: id,
            notShortOrder: 0
          }
        })
        .then(res => {
          var statusData = JSON.parse(JSON.stringify(res.data));
          this.orders = statusData;
          this.requestStatus = statusData.map(function(i) {
            return {
              text: i["orderID"],
              value: i["orderID"]
            };
          });
        });
    },
    
    changeOrder(id) {
      console.log(id);
      for (var i = 0; i < this.orders.length; i++) {
        if (this.orders[i].orderID == id) {
          this.currentOrder = this.orders[i];
          this.form.itemCategory = this.orders[i].itemID;
          this.form.customerFullName = this.orders[i].customerFullName;
          this.form.customerPhoneNumber = this.orders[i].customerPhoneNumber;
          this.form.orderDescription = this.orders[i].orderDescription;
          this.form.workplace = this.orders[i].workPlaceID;
          this.form.master = this.orders[i].employeeID;
        }
      }
      // var order = this.orders.filter(i=>i.orderID == id);
      // console.log(order);
    },
    handleSelect(arg){
      this.form.startTime = arg.startStr;
      this.form.endTime = arg.endStr;
      this.$bvModal.show("modal-center");
      console.log('handleSelect');
    },
     handleDateClick(arg) {
       console.log('handleDateClick');
      this.form.startTime = arg.dateStr;
      var endDate = new Date(this.form.startTime);
      console.log(endDate);
      endDate.setMinutes(endDate.getMinutes() + 60);
      console.log(endDate);
      var formatted_date = endDate.getFullYear() + "-" + (endDate.getMonth() + 1) + "-" + endDate.getDate() + " " + endDate.getHours() + ":" + endDate.getMinutes() + ":" + endDate.getSeconds();
      this.form.endTime = formatted_date;
      console.log(this.form.endTime);
      this.$bvModal.show("modal-center");
       console.log(arg.dateStr);
      // var d1 = new Date(this.form.startTime);
      // console.log(d1);
      // console.log(d1.toISOString());
      // console.log('test');
      // endTime = new Date(d1);
      // endTime.setMinutes(d1.getMinutes() + 30);
      // var d1= endTime.toISOString();
      // this.form.endTime = endTime.toISOString; 

      // console.log(this.form.endTime);
      // this.$bvModal.show("modal-center");
      // if (confirm(" " + arg.dateStr + " ?")) {
      //   this.calendarEvents.push({
      //     title: "New Event",
      //    start: arg.date
      //   });
      // }
    
    /*  function two(num) { return ("0" + num).slice(-2);} */ // подставляет недостающий ноль 

    // t - время в секундах из БД сервера
    // mydate возвращает строку  в формате например 12.08.2015 19:03
    /* function mydate(t) {
      var d = new Date((t-time_zone*60)*1000);
      return two(d.getUTCDate())+'.'+ two(d.getUTCMonth()+1)+'.'+d.getUTCFullYear()+' '+ two(d.getUTCHours())+':'+ two(d.getUTCMinutes());
      console.log("two");
} */
     },
    changeWorkPlace(id) {
      this.form.workplace = id;
    },
    saveOrder() {
      console.log("saved");
      var orderId = this.form.orderstatus;
      var vehicleModelID = this.currentOrder.vehicleModelID;
      if (!vehicleModelID) {
        vehicleModelID = 1;
      }
      var vehicleModificationID = this.currentOrder.vehicleModificationID;
      if (!vehicleModificationID) {
        vehicleModificationID = 1;
      }
      // var employeeID = this.currentOrder.employeeID;
      // if (!employeeID){
      //   employeeID = id;
      // }
      // console.log (employeeID);

      this.$store
        .dispatch("setOrder", {
          params: {
            orderID: 0,
            workShopID: 1,
            customerFullName: this.form.customerFullName,
            customerPhoneNumber: this.form.customerPhoneNumber,
            itemID: this.form.itemCategory,
            orderDescription: this.form.orderDescription,
            vehicleModelID:  this.form.vehicleModelName,
            vehicleModificationID: this.form.vehicleModelName,
            vehicleRegistrationNumber:this.form.vehicleRegistrationNumber,
            employeeID: this.form.mechanic,
            employeeCreateOrderID: this.form.master,
            workPlaceID: this.form.workplace,
            startTime: this.form.startTime,
            endTime: this.form.endTime,
            orderStatusID: 2,
             vendorID: this.form.vendorName,
          }
        })
        .then(res => {
          this.$bvModal.hide("modal-center");
        });
    },
    getSelectedBrand(id) {
      console.log(id);

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
    }
    /*  onSubmit(evt) {
      evt.preventDefault();
      this.$store.dispatch("setOrder", {
        params: {
          workShopID: 1,
          orderStatusID: this.form.orderstatus
        }
      });
    }, */
   /*  toggleWeekends() {
      this.calendarWeekends = !this.calendarWeekends; // update a property
    }, */
   /*  gotoPast() {
      let calendarApi = this.$refs.fullCalendar.getApi(); // from the ref="..."
      calendarApi.gotoDate("2000-01-01"); // call a method on the Calendar object
    },
 */
   
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
.submit_bt{
    display: flex;
    justify-content: flex-end;
    margin-top: 10px;
}
textarea #orderDescription{
    overflow-y: auto;
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
.visibility{
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
.mr-b{
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
.fc-event-container{
  height: 80% !important ;
}
.fc-timeline-event.fc-h-event.fc-event.fc-start.fc-end.fc-draggable {
    height: 91% !important;
}
/* .fc-timeline-event.fc-h-event.fc-event.fc-start.fc-end.fc-draggable {
    height: 44px !important;
} */
.fc-time{
  display: none;
}
.fc-resourceTimelineDay-button,
.fc-resourceTimelineWeek-button {
  padding: 0.3em 1em;
  height: 2.2em;
  font-size: 1.2em;
}
.modal-footer{
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

#logout{
  display: flex;
  //padding: 10px;
  margin: 5px;
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
</style>
