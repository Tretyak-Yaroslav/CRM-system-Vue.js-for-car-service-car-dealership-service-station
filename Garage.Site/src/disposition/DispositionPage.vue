<template>
  <div style="margin:0px 10px;">
    <div class="logo">
      <img src="../../src/assets/logo_ad.png" alt="logo" />
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
    <b-modal id="modal-center" ref="modal"  title="Опрацювання заявки :">
      <div class="form-group">
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
        v-on:change="changeWorkPlace">
        </b-form-select>
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
        <b-form-select id="mechanic" 
        v-model="form.mechanic" 
        :options="mechanics" 
        required>
        </b-form-select>
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
            <b-form-input 
              id ="customerFullName"
              v-model="form.customerFullName"
            ></b-form-input>
          </div>
        </div>
        <div class="col-6 if-available right">
          <div class="form-group">
            <label class="control-label">Телефон</label>
            <b-form-input
            id="customerPhoneNumber"
            v-model="form.customerPhoneNumber"
            ></b-form-input>
          </div>
        </div>
        <div class="datatime">
          <label class="control-label">Початок роботи</label>
          <!-- <datetime type="datetime" v-model="datetimefrom" format="yyyy-MM-dd HH:mm:ss"></datetime> -->
          <datetime type="datetime" v-model="form.startTime" format="yyyy-MM-dd HH:mm:ss"></datetime>
        </div>
        <div class="datatime">
          <label class="control-label">Закінчення роботи</label>
          <!-- v-model="datetimeto" -->
          <datetime type="datetime" v-model="form.endTime" format="yyyy-MM-dd HH:mm:ss"></datetime>
        </div>
      </div>

      <b-form-textarea
       id="orderDescription" 
       v-model="form.orderDescription"
       placeholder="Коментар">
       </b-form-textarea>

       <b-button class="mt-3" variant="outline-danger" block @click="saveOrder">Save</b-button>
      <!-- <b-button class="mt-2" variant="outline-warning" block @click="toggleModal">Toggle Me</b-button> -->

    </b-modal>
  </div>
</template>

<script charset="utf-8">
import FullCalendar from "@fullcalendar/vue";
import resourceTimelinePlugin from "@fullcalendar/resource-timeline";
import interactionPlugin from "@fullcalendar/interaction";
import timeGridPlugin from "@fullcalendar/timegrid";


export default {
  created() {
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

    this.$store
      .dispatch("getEmployees", {
        params: { workShopID: 1, employeePostID: 2 }
      })
      .then(res => {
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
    
    this.$store.dispatch("getOrder", {params:{
      from: "2019-08-01",
      to: "2019-12-30",
      workShopID: 1,
      orderStatusID: 0,
      notShortOrder:0
    }}).then(res=>{
      var eventsData = JSON.parse(JSON.stringify(res.data));
      console.log(eventsData);
      this.events = eventsData.map(function(i){
          return{
            id: i["orderID"],
            resourceId: i["workPlaceID"],
            title: i["vendorName"],
            date: i["startTime"],
            end: i["endTime"],
            textColor:'white',
            class:'in_work',
            backgroundColor: i["calendarPluginsCode"]
          }
      });
    });
  },
  components: {
    FullCalendar
  },

  data() {
    return {
      orderstatus: {
        workShopID: "",
        orderStatusID: "",
        notShortOrder: ""
      },
      form: {
        master: "",
        mechanic: "",
        employes: "",
        status: "",
        orderstatus: "",
        orderStatusName:"",
        itemCategory:"",
        customerFullName:"",
        customerPhoneNumber:"",
        orderDescription:"",
        workplace:"",
        startTime:"",
        endTime: ""
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
      orderStatusNames:[],
      masters: [],
      mechanics: [],
      requestStatus: [],
      events: [],
      itemCategorys: [],
      orders: [],
      currentOrder:""
    };
  },
  
  methods: {
    changeOrderStatusName(id){
      this.form.orderStatusName = id;
      console.log(id);
      this.updateOrderListByOrderType(id);
    },
    updateOrderListByOrderType(id){
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
    changeOrder(id){
      console.log(id)
      for(var i=0; i< this.orders.length; i++){
        if(this.orders[i].orderID == id){
          this.currentOrder = this.orders[i];
          this.form.itemCategory = this.orders[i].itemID;
          this.form.customerFullName  = this.orders[i].customerFullName;
          this.form.customerPhoneNumber = this.orders[i].customerPhoneNumber;
          this.form.orderDescription = this.orders[i].orderDescription;
          this.form.workplace = this.orders[i].workPlaceID;     
          this.form.master = this.orders[i].employeeID;   
       }
      }
      // var order = this.orders.filter(i=>i.orderID == id);
      // console.log(order);
    },
    changeWorkPlace(id){
      console.log(id);
    },
    saveOrder(){
      console.log('saved');
      var orderId = this.form.orderstatus;
      var vehicleModelID = this.currentOrder.vehicleModelID;
      if(!vehicleModelID){
        vehicleModelID =1;
      }
      var vehicleModificationID =this.currentOrder.vehicleModificationID;
      if(!vehicleModificationID){
        vehicleModificationID =1;
      }

      this.$store.dispatch("setOrder", {params:{
        orderID: this.currentOrder.orderID,
        workShopID: 1,
        customerFullName: this.form.customerFullName,
        customerPhoneNumber: this.form.customerPhoneNumber,
        itemID: this.form.itemCategory,
        orderDescription: this.form.orderDescription,
        vehicleModelID: vehicleModelID,
        vehicleModificationID :vehicleModificationID,
        vehicleRegistrationNumber: this.currentOrder.vehicleRegistrationNumber,
        employeeID: this.currentOrder.employeeID,
        employeeCreateOrderID: this.currentOrder.employeeCreateOrderID,
        workPlaceID:this.form.workplace,
        startTime: this.form.startTime,
        endTime: this.form.endTime,
        orderStatusID:this.form.orderStatusName
      }})
      .then(res=>{
        this.$bvModal.hide("modal-center");
      })
    },
   /*  onSubmit(evt) {
      evt.preventDefault();
      this.$store.dispatch("setOrder", {
        params: {
          workShopID: 1,
          orderStatusID: this.form.orderstatus
        }
      });
    }, */
    toggleWeekends() {
      this.calendarWeekends = !this.calendarWeekends; // update a property
    },
    gotoPast() {
      let calendarApi = this.$refs.fullCalendar.getApi(); // from the ref="..."
      calendarApi.gotoDate("2000-01-01"); // call a method on the Calendar object
    },

    handleDateClick(arg) {
      this.form.startTime = arg.dateStr;
      console.log(arg.dateStr);
      var d1 = new Date(this.form.startTime),
      endTime = new Date(d1);
      endTime.setMinutes(d1.getMinutes() + 30);
      this.form.endTime = endTime.toISOString();
      console.log(this.form.endTime);
      this.$bvModal.show("modal-center");
      // if (confirm(" " + arg.dateStr + " ?")) {
      //   this.calendarEvents.push({
      
      //     title: "New Event",
      //     start: arg.date
         
      //   });
      // }
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
  justify-content: flex-end;
  height: 80px;
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
