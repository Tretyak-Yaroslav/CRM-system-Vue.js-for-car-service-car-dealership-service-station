<template>

  <b-container fluid>
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
      <b-col md="6" class="my-1">
        <b-form-group label-cols-sm="3" label="Показати" class="mb-0">
          <b-form-select v-model="perPage" :options="pageOptions"></b-form-select>
        </b-form-group>
      </b-col>
    </b-row>

    <!-- Main table element -->
    <b-table id="change"
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
      <template
        slot="employeeID"
        slot-scope="row"
      >{{ row.value.employeeFirstName }}</template>
      <template
        slot="employeeCreateOrderID"
        slot-scope="row"
      >{{ row.value.employeeCreateFirstName }} </template>

      <template slot="isActive" slot-scope="row">{{ row.value ? 'Yes :)' : 'No :(' }}</template>

      <template slot="actions" slot-scope="row">
        <b-button
          size="sm"
          @click="row.toggleDetails"
        >{{ row.detailsShowing ? 'Приховати' : 'Показати' }} деталі</b-button>

<!--         <div data-v-61251f08="" style="text-align: right; position: absolute; right: 5px; top: 5px;"><svg data-v-781ef5e4="" data-v-61251f08="" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 32 32" aria-labelledby="cloudDownloadAlt" role="presentation" class="download-icon"><title data-v-781ef5e4="" id="cloudDownloadAlt" lang="en">cloudDownloadAlt icon</title> <g data-v-781ef5e4="" fill="#bbbbbb"><path data-v-781ef5e4="" d="M 26.166,16c 1.868-4.29, 0.716-7.018-0.222-8.332c-1.424-1.994-4.018-3.088-6.296-2.65 C 15.688,5.774, 14,8.458, 14,14l0,4.628 L 11.684,16.312c-0.39-0.39-1.024-0.39-1.414,0s-0.39,1.024,0,1.414l 4.024,4.022 c 0.202,0.202, 0.468,0.294, 0.732,0.288c 0.264,0.006, 0.53-0.086, 0.732-0.288l 4.044-4.042c 0.39-0.39, 0.39-1.024,0-1.414 s-1.024-0.39-1.414,0L 16,18.678L 16,14 c0-5.768, 1.986-6.628, 4.020-7.018c 1.306-0.24, 3.196,0.308, 4.294,1.848 c 1.344,1.878, 1.086,4.664-0.726,7.84c-0.192,0.338-0.172,0.756, 0.052,1.072s 0.618,0.476, 0.992,0.408 c 0.242-0.042, 0.964-0.152, 1.42-0.152C 28.23,17.998, 30,19.792, 30,22c0,2.206-1.794,4-4,4l-19.854,0.012C 3.822,25.668, 2,23.466, 2,21 c0-2.456, 1.844-4.57, 4.292-4.92l 0.86-0.124c 0.492-0.070, 0.858-0.492, 0.858-0.99L 7.994,13.902C 8,10.32, 10.208,7.376, 13.25,6.902 C 13.794,6.816, 14.168,6.306, 14.084,5.76C 13.998,5.214, 13.5,4.844, 12.94,4.926C 8.92,5.552, 6,9.326, 5.994,13.898 c0,0.002, 0.016,0.202, 0.016,0.202l0,0 C 2.584,14.59,0,17.556,0,21c0,3.492, 2.516,6.496, 6,7l 20,0 c 3.308,0, 6-2.692, 6-6 C 32,18.728, 29.392,16.060, 26.166,16z"></path></g></svg></div>
 -->      </template>

      <template slot="row-details" slot-scope="row">
        <b-card>
          <ul>
            <li v-for="(value, key) in row.item" :key="key">{{changeName(key)}} {{value }}</li>
          </ul>
        </b-card>
      </template>
    </b-table>

    <b-row>
      <b-col md="6" class="my-1">
        <b-pagination
          v-model="currentPage"
          :total-rows="totalRows"
          :per-page="perPage"
          class="my-0"
        ></b-pagination>
      </b-col>
    </b-row>

    <!-- Info modal -->
    <b-modal :id="infoModal.id" :title="infoModal.title" ok-only @hide="resetInfoModal">
      <pre>{{ infoModal.content }}</pre>
    </b-modal>
  </b-container>

</template>


<script>
export default {
  created() {
    var date1 = new Date();
    date1.setDate(date1.getDate() -3);

    var date2 = new Date();
    date2.setDate(date2.getDate() + 3);

    console.log('Date1: ' + date1.toISOString().slice(0,10));
    console.log('Date2: ' + date2.toISOString().slice(0,10));
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
        var orders = JSON.parse(JSON.stringify(res.data));
        console.log(orders);
        this.items = orders.map(function(i) {
          return {
            orderID: i["orderID"],
            startTime: i["createDate"],
            orderStatusName: i["orderStatusName"],
            customerPhoneNumber: i["customerPhoneNumber"],
            employeeCreateOrderID: {
              employeeCreateLastName: i["employeeCreateLastName"],
              employeeCreateFirstName: i["employeeCreateFirstName"]
            },
            employeeID: {
              employeeFirstName: i["employeeFirstName"],
              employeeLastName: i["employeeLastName"]
            },
            vendorName: i["vendorName"],
            vehicleModelName: i["vehicleModelName"],
            vehicleRegistrationNumber: i["vehicleRegistrationNumber"],
            itemName: i["itemName"],
            orderDescription: i["orderDescription"]
          };
        });
      });
  },
  data() {
    return {
      items: [
        {
          orderID: "",
          startTime: "",
          orderStatusName: "",
          customerPhoneNumber: "",
          employeeCreateOrderID: {
            employeeCreateLastName: "",
            employeeCreateFirstName: ""
          },
          employeeID: {
            employeeFirstName: "",
            employeeLastName: ""
          },
          vendorName: "",
          vehicleModelName: "",
          vehicleRegistrationNumber: "",
          itemName: "",
          orderDescription: ""
        }
      ],
      fields: [
        {
          key: "orderID",
          label: "Номер",
          sortable: true,
          sortDirection: "desc"
        },
        {
          key: "startTime",
          label: "Час запису",
          sortable: false,
          name:"",
          /*  sortDirection: "desc" */
        },
        {
          key: "customerPhoneNumber",
          label: "Телефон",
          sortable: true,
          sortDirection: "desc"
        },
        {
          key: "employeeCreateOrderID",
          label: "Майстер-приймальник",
          sortable: true,
          sortDirection: "desc"
        },
        {
          key: "employeeID",
          label: "Механік",
          sortable: true,
          sortDirection: "desc"
        },
        { key: "actions", label: "Показати деталі" }
      ],
      totalRows: 1,
      currentPage: 1,
      perPage: 50,
      pageOptions: [5, 10, 15, 50],
      sortBy: null,
      sortDesc: false,
      sortDirection: "asc",
      filter: null,
      infoModal: {
        id: "info-modal",
        title: "",
        content: ""
      }
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
  mounted() {
    // Set the initial number of items
    this.totalRows = this.items.length;
  },
  methods: {
    info(item, index, button) {
      this.infoModal.title = `Row index: ${index}`;
      this.infoModal.content = JSON.stringify(item, null, 2);
      this.$root.$emit("bv::show::modal", this.infoModal.id, button);
    },
    resetInfoModal() {
      this.infoModal.title = "";
      this.infoModal.content = "";
    },
    onFiltered(filteredItems) {
      this.totalRows = filteredItems.length;
      this.currentPage = 1;
    },
    changeName(name) {
      if (name === "orderID") {
        return "Номер замовлення:";
      }
      if (name == "startTime") {
        return "Час створення замовлення :";
      }
      if (name == "customerPhoneNumber") {
        return "Номер телефону :";
      }
      if (name == "employeeCreateOrderID") {
        return "Майстер-приймальник :";
      }
      if (name == "employeeID") {
        return "Механік:";
      }
      if (name == "vehicleModelName") {
        return "Модель :";
      }
      if (name == "orderDescription") {
        return "Коментар :";
      }
      if (name == "orderStatusName") {
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
