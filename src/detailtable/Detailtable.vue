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
              <option slot="first" :value="null"> </option>
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
      <template slot="name" slot-scope="row">
        {{ row.value.first }} {{ row.value.last }}
      </template>

      <template slot="isActive" slot-scope="row">
        {{ row.value ? 'Yes :)' : 'No :(' }}
      </template>

      <template slot="actions" slot-scope="row">
        <!-- <b-button size="sm" @click="info(row.item, row.index, $event.target)" class="mr-1">
          Info modal
        </b-button> -->
        <b-button size="sm" @click="row.toggleDetails">
          {{ row.detailsShowing ? 'Приховати' : 'Показати' }}  деталі
        </b-button>
      </template>

      <template slot="row-details" slot-scope="row">
        <b-card>
          <ul>
            <li v-for="(value, key) in row.item" :key="key">{{ key }}: {{ value }}</li>
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
        { number:1, time:'17:35', phone:+380960547933, name: { last: ' Васильович ',  first: 'Петро'  }, locksmith:{ last_two:'Сторожук', first_two: 'Васильович'} },
        { number:2, time:'14:30', phone:+380960540000, name: { last: 'Васильович', first: 'Василь'  }, locksmith:{ last_two:'Сторожук', first_two: 'Васильович'} },
        { number:3, time:'11:05', phone:+380960547777, name: { last: 'Васильович', first: 'Андрій'  }, locksmith:{ last_two:'Сторожук', first_two: 'Васильович'} },
        { number:4, time:'9:05',  phone:+3809609654484, name: { last: 'Васильович', first: 'Сергій'  }, locksmith:{ last_two:'Сторожук', first_two: 'Васильович'} },
        { number:5, time:'12:35', phone:+380930004544, name: { last: 'Васильович', first: 'Василь'  }, locksmith:{ last_two:'Сторожук', first_two: 'Васильович'} },

        { number:2, time:'17:35', phone:+380960547933, name: { last: ' Васильович ',  first: 'Петро'  }, locksmith:{ last_two:'Сторожук', first_two: 'Васильович'} },
        { number:2, time:'14:30', phone:+380960540000, name: { last: 'Васильович', first: 'Василь'  }, locksmith:{ last_two:'Сторожук', first_two: 'Васильович'} },
        { number:3, time:'11:05', phone:+380960547777, name: { last: 'Васильович', first: 'Андрій'  }, locksmith:{ last_two:'Сторожук', first_two: 'Васильович'} },
        { number:4, time:'9:05',  phone:+3809609654484, name: { last: 'Васильович', first: 'Сергій'  }, locksmith:{ last_two:'Сторожук', first_two: 'Васильович'} },
        { number:5, time:'12:35', phone:+380930004544, name: { last: 'Васильович', first: 'Василь'  }, locksmith:{ last_two:'Сторожук', first_two: 'Васильович'} },

        ],
        fields: [
         { key: 'number', label: 'Номер', sortable: true, sortDirection: 'desc' },
         { key: 'time', label: 'Час запису', sortable: true, sortDirection: 'desc' },
         { key: 'phone', label: 'Телефон', sortable: true, sortDirection: 'desc' },
          { key: 'name', label: 'Майстер-приймальник', sortable: true, sortDirection: 'desc' },
          { key: 'locksmith ', label: 'Механік', sortable: true, sortDirection: 'desc' },
          
          { key: 'actions', label: 'Показати деталі' }
        ],
        totalRows: 1,
        currentPage: 1,
        perPage: 5,
        pageOptions: [5, 10, 15],
        sortBy: null,
        sortDesc: false,
        sortDirection: 'asc',
        filter: null,
         infoModal: {
          id: 'info-modal',
          title: '',
          content: ''
        } 
      }
    },
    computed: {
      sortOptions() {
        // Create an options list from our fields
        return this.fields
          .filter(f => f.sortable)
          .map(f => {
            return { text: f.label, value: f.key }
          })
      }
    },
    mounted() {
      // Set the initial number of items
      this.totalRows = this.items.length
    },
    methods: {
      info(item, index, button) {
        this.infoModal.title = `Row index: ${index}`
        this.infoModal.content = JSON.stringify(item, null, 2)
        this.$root.$emit('bv::show::modal', this.infoModal.id, button)
      },
      resetInfoModal() {
        this.infoModal.title = ''
        this.infoModal.content = ''
      },
      onFiltered(filteredItems) {
        this.totalRows = filteredItems.length
        this.currentPage = 1
      }
    }
  }
</script>