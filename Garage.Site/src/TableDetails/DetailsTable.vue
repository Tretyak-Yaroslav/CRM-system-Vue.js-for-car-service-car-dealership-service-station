
<template>
  <DetailsTable>
    <b-container fluid class="Detailtable" id="Detailtable">
      <!-- User Interface controls -->
      <b-row>
        <b-col md="6" class="my-1">
          <b-input-group>
            <b-form-input v-model="filter" placeholder="Введіть для пошуку"></b-form-input>
            <b-input-group-append>
              <b-button :disabled="!filter" @click="filter = ''">Очистити</b-button>
            </b-input-group-append>
          </b-input-group>
        </b-col>
        <b-col md="6" class="my-1">
          <b-form-group label-cols-sm="3" label="Сортувати" class="mb-0">
            <b-input-group>
              <b-form-select v-model="sortBy" :options="sortOptions">
                <option slot="first" :value="null"></option>
              </b-form-select>
            </b-input-group>
          </b-form-group>
        </b-col>
      </b-row>
      <!-- Main table element -->
      <b-table
        id="change"
        show-empty
        stacked="md"
        :items="items"
        :fields="fields"
        :current-page="currentPage"
        :per-page="perPage"
        :filter="filter"
        :sort-by.sync="sortBy"
        :sort-desc.sync="sortDesc"
        :sort-direction="sortDirection"
        @filtered="onFiltered"
      >
        <template slot="employeeID" slot-scope="row">{{ row.value.employeeFirstName }}</template>
        <template
          slot="employeeMasterID"
          {{
          row.item.time
          }}
          slot-scope="row"
        >{{row.value.employeeMasterLastName + ' ' + row.value.employeeMasterFirstName }}</template>
        <template
          slot="modelAndMakeCar"
          {{row.item.time}}
          slot-scope="row"
        >{{row.value.vendorName + ' ' + row.value.vehicleModelName}}</template>
        <template
          slot="startTime"
          {{row.item.time}}
          slot-scope="row"
        >{{row.value.startTime + ' - ' + row.value.endTime}}</template>
        <template slot="isActive" slot-scope="row">{{ row.value ? 'Yes :)' : 'No :(' }}</template>
        <template slot="actions" slot-scope="row">
          <b-button size="sm" @click="info(row.item,$event.target)" class="mr-1">Обробити</b-button>
        </template>
        <template slot="row-details" slot-scope="row">
          <b-card>
            <ul>
              <li v-for="(value, key) in row.item" :key="key">{{changeName(key)}} {{value }}</li>
            </ul>
          </b-card>
        </template>
      </b-table>
      <b-row>
        <b-col md="12" class="my-1 d-flex justify-content-end">
          <b-pagination
            v-model="currentPage"
            :total-rows="totalRows"
            :per-page="perPage"
            class="my-0"
          ></b-pagination>
          <b-form-group class="mb-0 ml-2">
            <b-form-select v-model="perPage" :options="pageOptions"></b-form-select>
          </b-form-group>
        </b-col>
      </b-row>
    </b-container>
    <b-modal id="editing" ref="modal" title="Редагування заявки:">
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
  </DetailsTable>
</template>
<script>
import MaskedInput from "vue-text-mask";
import moment from "moment";
import "moment/locale/uk";
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
            backgroundColor: i["employeeMasterColor"]
          };
        });
      });
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
        var querys = JSON.parse(JSON.stringify(res.data));
        this.items = querys.map(function(i) {
          return {
            queryID: i["queryID"],
            DateTime: moment(String(i["startTime"])).format("L"),
            queryStatusName: i["queryStatusName"],
            variant: i["queryStatusColor"],
            customerPhoneNumber: i["customerPhoneNumber"],
            employeeMasterID: {
              employeeMasterLastName: i["employeeMasterLastName"],
              employeeMasterFirstName: i["employeeMasterFirstName"]
            },
            startTime: {
              startTime: moment(String(i["startTime"])).format("LT"),
              endTime: moment(String(i["endTime"])).format("LT")
            },
            employeeID: {
              employeeFirstName: i["employeeFirstName"],
              employeeLastName: i["employeeLastName"]
            },
            modelAndMakeCar: {
              vendorName: i["vendorName"],
              vehicleModelName: i["vehicleModelName"]
            },
            vehicleRegistrationNumber: i["vehicleRegistrationNumber"],
            itemName: i["itemName"],
            queryDescription: i["queryDescription"]
          };
        });
      });
  },
  components: {
    MaskedInput
  },
  data() {
    return {
      workShopID: "",
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
        DateTime: "",
        endTime: "",
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
        vehicleID: "",
        customerID: ""
      },

      items: [
        {
          queryID: "",
          DateTime: "",
          startTime: {
            startTime: "",
            endTime: ""
          },
          queryStatusName: "",
          queryStatusColor: "",
          customerPhoneNumber: "",

          employeeMasterID: {
            employeeMasterLastName: "",
            employeeMasterFirstName: ""
          },
          employeeID: {
            employeeFirstName: "",
            employeeLastName: ""
          },
          modelAndMakeCar: {
            vendorName: "",
            vehicleModelName: ""
          },
          vehicleRegistrationNumber: "",
          itemName: "",
          queryDescription: ""
        }
      ],
      fields: [
        {
          key: "queryID",
          label: "Номер",
          sortable: true,
          sortDirection: "desc"
        },
        {
          key: "queryStatusName",
          variant: "queryStatusColor",
          label: "Статус",
          sortable: true,
          sortDirection: "desc"
        },
        {
          key: "DateTime",
          label: "Дата запису",
          sortable: true,
          name: "",
          sortDirection: "desc"
        },
        {
          key: "startTime",
          label: "Час запису",
          sortable: true,
          name: "",
          sortDirection: "desc"
        },
        {
          key: "customerPhoneNumber",
          label: "Телефон",
          sortable: false
        },
        {
          key: "modelAndMakeCar",
          label: "Автомобіль",
          sortable: false
        },
        {
          key: "employeeMasterID",
          label: "Майстер-приймальник",
          sortable: true,
          sortDirection: "desc"
        },
        { key: "actions", label: "Керування" }
      ],
      totalRows: 1,
      currentPage: 1,
      perPage: 10,
      pageOptions: [5, 10, 15, 50, 100],
      sortBy: null,
      sortDesc: true,
      sortDirection: "asc",
      filter: null,
      infoModal: {
        id: "editing",
        title: "",
        content: ""
      },
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
      queryData: [],
      queryNumbers: [],
      currentQuery: []
    };
  },
  computed: {
    sortOptions() {
      // Create an options list from our fields
      return this.fields
        .filter(f => f.sortable)
        .map(f => {
          return { text: f.label, value: f.key };
        });
    }
  },
  sortItems() {
    return this.items.sort((a, b) => {
      if (+a.queryID > +b.queryID) {
        return -1;
      }
      if (+a.queryID < +b.queryID) {
        return 1;
      }
      return 0;
    });
  },

  mounted() {
    // Set the initial number of items
    this.totalRows = this.items.length;
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
  methods: {
    info(item, queryID) {
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
            queryID: item.queryID
          }
        })
        .then(res => {
          var queryData = JSON.parse(JSON.stringify(res.data));
          for (var i = 0; i < queryData.length; i++) {
            if (queryData[i].queryID == item.queryID) {
              this.form.id = queryData[i].queryID;
              this.form.customerFullNameChange = queryData[i].customerFullName;
              this.form.customerPhoneNumberChange =
                queryData[i].customerPhoneNumber;
              this.form.itemCategoryChange = queryData[i].itemID;
              this.form.queryDescriptionChange = queryData[i].queryDescription;
              this.form.vendorName = queryData[i].vendorID;
              this.form.vehicleModelNameChange = queryData[i].vehicleModelID;
              this.form.vehicleRegistrationNumberChange =
                queryData[i].vehicleRegistrationNumber;
              this.form.mechanicChange = queryData[i].employeeID;
              this.form.masterChange = queryData[i].employeeMasterID;
              this.form.workplaceChange = queryData[i].workPlaceID;
              this.form.startTimeChange = formated_handleStart;
              this.form.endTimeChange = queryData[i].endTime;
              this.form.queryStatusName = queryData[i].queryStatusID;
              this.form.vendorNameChange = queryData[i].vendorID;
              this.form.customerID = queryData[i].customerID;
              this.form.vehicleID = queryData[i].vehicleID
            }
          }
        });
      this.$bvModal.show("editing");
    },
    changeQuery(evt) {
      for (var i = 0; i < this.queryData.length; i++) {
        if (this.queryData[i].queryID == this.form.id) {
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
            vendorID: this.form.vendorName,
            customerID: this.form.customerID,
            vehicleID: this.form.vehicleID
          }
        })
        .then(res => {
          this.$bvModal.hide("editing");
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
            vehicleID: 0,
            customerID: 0,
          }
        })
        .then(res => {
          this.$bvModal.hide("modal-center");
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
    onFiltered(filteredItems) {
      this.totalRows = filteredItems.length;
      this.currentPage = 1;
    },
    changeName(name) {
      if (name === "queryID") {
        return "Номер замовлення:";
      }
      if (name == "DateTime") {
        return "Запланована дата";
      }
      if (name == "startTime") {
        return "Час створення замовлення :";
      }
      if (name == "customerPhoneNumber") {
        return "Номер телефону :";
      }
      if (name == "employeeMasterID") {
        return "Майстер-приймальник :";
      }
      if (name == "employeeID") {
        return "Механік:";
      }
      if (name == "vehicleModelName") {
        return "Модель :";
      }
      if (name == "queryDescription") {
        return "Коментар :";
      }
      if (name == "queryStatusName") {
        return "Статус заявки :";
      }
      if (name == "vehicleRegistrationNumber") {
        return "Номер автомобіля :";
      }
      if (name == "vendorName") {
        return "Марка :";
      }
      if (name == "itemName") {
        return "Послуга :";
      }
    },
    addDays(days) {
      var result = new Date();
      result.setDate(result.getDate() + days);
      return result;
    }
  }
};
</script>
 <style lang="scss" scoped>
@media screen and (max-width: 600px) {
  .table {
    font-size: 0.9em;
  }
  .btn-sm,
  .btn-group-sm > .btn {
    padding: 0.25rem 0.2rem;
    font-size: 0.875rem;
  }
  .table th {
    text-align: center;
    padding: 0.5rem !important;
  }
  .table.b-table.b-table-stacked-md {
    overflow: scroll;
    min-width: 443px;
  }
}
li:last-child {
  display: none;
}
</style>
