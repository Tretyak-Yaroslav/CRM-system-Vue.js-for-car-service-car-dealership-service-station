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
    <b-table
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
      >{{ row.value.employeeFirstName }} {{ row.value.employeeLastName }}</template>
      <template
        slot="employeeCreateOrderID"
        slot-scope="row"
      >{{ row.value.employeeCreateFirstName }} {{ row.value.employeeCreateLastName }}</template>
      <template slot="isActive" slot-scope="row">{{ row.value ? 'Yes :)' : 'No :(' }}</template>

      <template slot="actions" slot-scope="row">
        <!-- <b-button size="sm" @click="info(row.item, row.index, $event.target)" class="mr-1">
          Info modal
        </b-button>-->
        <b-button
          size="sm"
          @click="row.toggleDetails"
        >{{ row.detailsShowing ? 'Приховати' : 'Показати' }} деталі</b-button>
      </template>

      <template slot="row-details" slot-scope="row">
        <b-card>
          <ul>
            <li v-for="(value, key) in row.item" :key="key">{{ }} {{ }}</li>
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
  data() {
    return {
      items: [
        {
          orderID: "",
          startTime: "",
          customerPhoneNumber: "",
          employeeCreateOrderID: {
            employeeCreateLastName: "",
            employeeCreateFirstName: ""
          },
          employeeID: { employeeFirstName: "", employeeLastName: "" }
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
          sortable: true,
          sortDirection: "desc"
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
          key: "employeeID ",
          label: "Механік",
          sortable: true,
          sortDirection: "desc"
        },
        { key: "actions", label: "Показати деталі" }
      ],
      totalRows: 1,
      currentPage: 1,
      perPage: 5,
      pageOptions: [5, 10, 15],
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
    }
  }
};
</script>
 <style lang="scss" scoped>
@media screen and (max-width: 600px){
.table{
  font-size: 0.7em;
}
.btn-sm, .btn-group-sm > .btn {
    padding: 0.25rem 0.2rem;
    font-size: 0.875rem;
    
}
.table th {
    text-align: center;
    padding: 0.5rem !important;
}

.table.b-table.b-table-stacked-md{
 overflow: scroll;
  min-width: 443px;
}
}
</style>
