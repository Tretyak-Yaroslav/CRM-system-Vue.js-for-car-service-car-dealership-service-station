<template>
  <div style="margin:0px 10px;">
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
      :allDay="true"
      :eventClick="true"
      @eventClick="eventClick"
      @dateClick="handleDateClick"
      @select="handleSelect"
    />
    <b-button v-b-modal.modal-center class="visibility">Open Modal</b-button>
    <b-modal id="modal-center" ref="modal" title="Створення заявки :">
      <div class="row">
        <div class="col-6 if-available left">
          <div class="form-group">
            <label class="control-label">Ім'я:</label>
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
            <label class="control-label">Телефон</label>
            <masked-input
              v-model="form.customerPhoneNumber"
              id="customerPhoneNumber"
              required
              type="text"
              name="phone"
              class="form-control"
              :mask="['(', /[1-9]/, /\d/, /\d/, ')', ' ', /\d/, /\d/, /\d/, '-', /\d/, /\d/, /\d/, /\d/]"
              :guide="false"
              placeholderChar="#"
            />
          </div>
        </div>
        <div class="col-6 if-available left">
          <label class="control-label">Початок роботи</label>
          <b-form-input id="time" type="datetime" class="mr-b" v-model="form.startTime"></b-form-input>
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
      <b-form-group
        id="vehicleRegistrationNumber"
        label="Номер автомобіля:"
        label-for="vehicleRegistrationNumber"
      >
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
        <b-form-select id="master" v-model="form.master" :options="masters" required></b-form-select>
      </div>
      <div class="form-group">
        <label class="control-label">Механік</label>
        <b-form-select id="mechanic" v-model="form.mechanic" :options="mechanics" required></b-form-select>
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
      <b-button class="mt-3" variant="success" block @click="saveOrder">Cтворити заявку</b-button>
    </b-modal>

    <!-- Short statement selection - working version -->
    <b-modal id="modal-editing" ref="modal" title="Редагування заявки:">
      <div class="row">
        <div class="col-6 if-available left">
          <div class="form-group">
            <label class="control-label">Статус</label>
            <b-form-select
              id="master"
              v-model="form.orderStatusName"
              :options="orderStatusNames"
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
              :mask="['(', /[1-9]/, /\d/, /\d/, ')', ' ', /\d/, /\d/, /\d/, '-', /\d/, /\d/, /\d/, /\d/]"
              :guide="false"
              placeholderChar="#"
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
        id="orderDescription"
        v-model="form.orderDescriptionChange"
        placeholder="Коментар"
      ></b-form-textarea>
      <b-button class="mt-3" variant="outline-success" block @click="changeOrder">Зберегти зміни</b-button>
    </b-modal>
    <DetailsTable></DetailsTable>
  </div>
</template>
<script charset="utf-8">
import FullCalendar from "@fullcalendar/vue";
import resourceTimelinePlugin from "@fullcalendar/resource-timeline";
import interactionPlugin from "@fullcalendar/interaction";
import timeGridPlugin from "@fullcalendar/timegrid";
import MaskedInput from "vue-text-mask";
import axios from "axios";
import DetailsTable from "../TableDetails/DetailsTable";

export default {
  created() {
    const currentUser = JSON.parse(localStorage.getItem("currentUser"));
        if (currentUser) {
      axios.defaults.headers.common["Authorization"] =
        "Bearer " + currentUser.token;
    }
    var date1 = new Date();
    date1.setDate(date1.getDate() - 3);
    var date2 = new Date();
    date2.setDate(date2.getDate() + 3);
   /*  console.log("Date1: " + date1.toISOString().slice(0, 10));
    console.log("Date2: " + date2.toISOString().slice(0, 10)); */
    this.$store.dispatch("getOrderStatus", { params: { id: 0 } }).then(res => {
      var statusData = JSON.parse(JSON.stringify(res.data));
      this.orderStatusNames = statusData.map(function(i) {
        return {
          text: i["orderStatusName"],
          value: i["orderStatusID"]
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
   /*    console.log(this.workplaces); */
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
          from: date1.toISOString().slice(0, 10),
          to: date2.toISOString().slice(0, 10),
          workShopID: 1,
          orderStatusID: 0,
          notShortOrder: 0
        }
      })
      .then(res => {
        var eventsData = JSON.parse(JSON.stringify(res.data));
       /*  console.log(eventsData); */
        this.events = eventsData.map(function(i) {
          return {
            id: i["orderID"],
            resourceId: i["workPlaceID"],
            title:
            i["vehicleRegistrationNumber"],
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
    MaskedInput,
    DetailsTable
  },
  data() {
    return {
      orderstatus: {
        workShopID: "",
        orderStatusID: "",
        notShortOrder: "",
        phone: ""
      },
      form: {
        master: "",
        mechanic: "",
        employes: "",
        status: "",
        orderStatusName: "",
        itemCategory: "",
        customerFullName: "",
        customerPhoneNumber: "",
        orderDescription: "",
        workplace: "",
        startTime: "",
        endTime: "",
        vehicleModelName: "",
        vehicleRegistrationNumber: "",
        vendorName: "",
        itemCategoryChange: "",
        customerFullNameChange: "",
        customerPhoneNumberChange: "",
        orderDescriptionChange: "",
        masterChange: "",
        startTimeChange: "",
        endTimeChange: "",
        mechanicChange: "",
        orderStatusNameChange: "",
        workplaceChange: "",
        vendorNameChange: "",
        vehicleModelNameChange: "",
        vehicleRegistrationNumberChange: "",
        id:""
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
      orderNumbers: [],
      currentOrder: []
    };
  },
  methods: {
    logout() {
      localStorage.removeItem("currentUser");
      delete axios.defaults.headers.common["Authorization"];
      this.$router.push("/");
    },
    changeOrderStatusName(id) {
      this.form.orderStatusName = id;
     /*  console.log(id); */
      this.updateOrderListByOrderType(id);
    },
    updateOrderListByOrderType(id) {
      var date1 = new Date();
      date1.setDate(date1.getDate() - 3);

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
    handleSelect(arg) {
      this.form.startTime = arg.startStr;
      var handleStart = new Date(this.form.startTime);
   /*    console.log(handleStart); */
      this.form.endTime = arg.endStr;
      var formated_handleStart =
        (handleStart.getHours() < 10 ? "0" : "") +
        handleStart.getHours() +
        ":" +
        (handleStart.getMinutes() < 10 ? "0" : "") +
        handleStart.getMinutes() +
        ":" +
        (handleStart.getSeconds() < 10 ? "0" : "") +
        handleStart.getSeconds();
      this.form.startTime = formated_handleStart;
      var handleEnd = new Date(this.form.endTime);
      var formated_handleEnd =
        (handleEnd.getHours() < 10 ? "0" : "") +
        handleEnd.getHours() +
        ":" +
        (handleEnd.getMinutes() < 10 ? "0" : "") +
        handleEnd.getMinutes() +
        ":" +
        (handleEnd.getSeconds() < 10 ? "0" : "") +
        handleEnd.getSeconds();
      this.form.endTime = formated_handleEnd;
      this.$bvModal.show("modal-center");
   /*    console.log("handleSelect");
      console.log(arg.startStr); */
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
        startDate.getMinutes() +
        ":" +
        (startDate.getSeconds() < 10 ? "0" : "") +
        startDate.getSeconds();

      this.form.startTime = formatted_date1;
      var formatted_date =
        (endDate.getHours() < 10 ? "0" : "") +
        endDate.getHours() +
        ":" +
        (endDate.getMinutes() < 10 ? "0" : "") +
        endDate.getMinutes() +
        ":" +
        (endDate.getSeconds() < 10 ? "0" : "") +
        endDate.getSeconds();
      this.form.endTime = formatted_date;
      this.$bvModal.show("modal-center");


      this.form.startTimeChange = formatted_date1;
      var startDate = new Date(this.form.startTimeChange);
      var endDate = new Date(this.form.startTimeChange);
      endDate.setMinutes(endDate.getMinutes() + 60);
      var formatted_date1 =
        (startDate.getHours() < 10 ? "0" : "") +
        startDate.getHours() +
        ":" +
        (startDate.getMinutes() < 10 ? "0" : "") +
        startDate.getMinutes() +
        ":" +
        (startDate.getSeconds() < 10 ? "0" : "") +
        startDate.getSeconds();

      this.form.startTimeChange = formatted_date1;
      var formatted_date =
        (endDate.getHours() < 10 ? "0" : "") +
        endDate.getHours() +
        ":" +
        (endDate.getMinutes() < 10 ? "0" : "") +
        endDate.getMinutes() +
        ":" +
        (endDate.getSeconds() < 10 ? "0" : "") +
        endDate.getSeconds();
      this.form.endTimeChange = formatted_date;
    
    },
    eventClick(arg) {
      var id = arg.event._def.publicId;
      var date1 = new Date();
      date1.setDate(date1.getDate() - 3);
      var date2 = new Date();
      date2.setDate(date2.getDate() + 3);
      this.$store
        .dispatch("postOrder", {
          params: {
            from: date1.toISOString().slice(0, 10),
            to: date2.toISOString().slice(0, 10),
            workShopID: 1,
            orderStatusID: 0,
            notShortOrder: 0,
            orderID: id
          }
        })
        .then(res => {
          var orderData = JSON.parse(JSON.stringify(res.data));
          this.orderNumbers = orderData;

          for (var i = 0; i < this.orderNumbers.length; i++) {
            if (this.orderNumbers[i].orderID == id) {
              this.currentOrder = this.orderNumbers[i];
              this.form.id = id;
              this.form.itemCategoryChange = this.orderNumbers[i].itemID;
              this.form.customerFullNameChange = this.orderNumbers[i].customerFullName;
              this.form.customerPhoneNumberChange = this.orderNumbers[i].customerPhoneNumber;
              this.form.orderDescriptionChange = this.orderNumbers[i].orderDescription;
              this.form.workplaceChange = this.orderNumbers[i].workPlaceID;
              this.form.masterChange = this.orderNumbers[i].employeeCreateOrderID;
              this.form.startTimeChange = this.orderNumbers[i].startTime;
              this.form.endTimeChange = this.orderNumbers[i].endTime;
              this.form.mechanicChange = this.orderNumbers[i].employeeID;
              this.form.orderStatusName = this.orderNumbers[i].orderStatusID;
              this.form.vendorNameChange = this.orderNumbers[i].vendorID;
              this.form.vehicleModelNameChange = this.orderNumbers[i].vehicleModelID;
              this.form.vehicleRegistrationNumberChange = this.orderNumbers[i].vehicleRegistrationNumber;
            }
          }

          this.orderNumber = orderData.map(function(i) {
            return {
              orderID: i["orderID"]
            };
          });
        });
      this.$bvModal.show("modal-editing");
    },
    changeOrder(evt) {
     /*   console.log("change");
      console.log(this.form.id);  */
      for (var i = 0; i < this.orderNumbers.length; i++) {
        if (this.orderNumbers[i].orderID == this.form.id) {
          /* this.currentOrder = this.orderNumbers[i];
          this.form.itemCategoryChange = this.orderNumbers[i].itemID;
          this.form.customerFullNameChange = this.orderNumbers[i].customerFullName;
          this.form.customerPhoneNumberChange = this.orderNumbers[i].customerPhoneNumber;
          this.form.orderDescriptionChange = this.orderNumbers[i].orderDescription;
          this.form.workplaceChange = this.orderNumbers[i].workPlaceID;
          this.form.masterChange = this.orderNumbers[i].employeeCreateOrderID;
          this.form.startTimeChange = this.orderNumbers[i].startTime;
          this.form.endTimeChange = this.orderNumbers[i].endTime;
          this.form.mechanicChange = this.orderNumbers[i].employeeID;
          this.form.orderStatusNameChange = this.orderNumbers[i].orderStatusName;
          this.form.vendorNameChange = this.orderNumbers[i].vehicleID;
          this.form.vehicleModelNameChange = this.orderNumbers[i].vehicleModelID;
          this.form.vehicleRegistrationNumberChange = this.orderNumbers[i].vehicleRegistrationNumber; */
        }
      }
     
     this.$store
        .dispatch("setOrder", {
          params: {
            orderID: this.form.id,
            workShopID: 1,
            customerFullName: this.form.customerFullNameChange,
            customerPhoneNumber: this.form.customerPhoneNumberChange,
            itemID: this.form.itemCategoryChange,
            orderDescription: this.form.orderDescriptionChange,
            vehicleModelID: this.form.vehicleModelNameChange,
            vehicleModificationID: this.form.vehicleModelNameChange,
            vehicleRegistrationNumber: this.form.vehicleRegistrationNumberChange,
            employeeID: this.form.mechanicChange,
            employeeCreateOrderID: this.form.masterChange,
            workPlaceID: this.form.workplaceChange,
            startTime: this.form.startTimeChange,
            endTime: this.form.endTimeChange,
            orderStatusID:  this.form.orderStatusName,
            vendorID: this.form.vendorNameChange
          }
        })
        
        .then(res => {
          this.$bvModal.hide("modal-editing");
        });
        
    },
    changeWorkPlace(id) {
      this.form.workplace = id;
    },
    saveOrder() {
     /*  console.log("saved"); */
      var orderId = this.form.orderstatus;
      var vehicleModelID = this.currentOrder.vehicleModelID;
      if (!vehicleModelID) {
        vehicleModelID = 1;
      }
      var vehicleModificationID = this.currentOrder.vehicleModificationID;
      if (!vehicleModificationID) {
        vehicleModificationID = 1;
      }
     
      this.$store
        .dispatch("setOrder", {
          params: {
            orderID: 0,
            workShopID: 1,
            customerFullName: this.form.customerFullName,
            customerPhoneNumber: this.form.customerPhoneNumber,
            itemID: this.form.itemCategory,
            orderDescription: this.form.orderDescription,
            vehicleModelID: this.form.vehicleModelName,
            vehicleModificationID: this.form.vehicleModelName,
            vehicleRegistrationNumber: this.form.vehicleRegistrationNumber,
            employeeID: this.form.mechanic,
            employeeCreateOrderID: this.form.master,
            workPlaceID: this.form.workplace,
            startTime: this.form.startTime,
            endTime: this.form.endTime,
            orderStatusID: 2,
            vendorID: this.form.vendorName
          }
        })
        .then(res => {
          this.$bvModal.hide("modal-center");
        });
    },
    
    getSelectedBrand(id) {
    /*   console.log(id); */
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
.fc-resource-area.fc-widget-header {
  width: 150px !important;
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
textarea #orderDescription {
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
#logout {
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
@media screen and (min-width: 575px) {
  .col-sm-2 .col-md-1 {
    width: auto !important;
  }
}
</style>