<template>
  <div>
    <b-form @submit="onSubmit" v-if="show">
      <b-form-group>
        <b-form-input
          id="input-1"
          v-model="form.countrycode"
          type="text"
          required
          placeholder="Enter countrycode"
        ></b-form-input>
      </b-form-group>
      <b-button type="submit" variant="primary" @click="send">Submit</b-button>
    </b-form>
    <b-card class="mt-3" header="Form Data Result">
      <pre class="m-0">{{ form }}</pre>
    </b-card>

    <ul v-for="item in items" class="border">
      <strong>{{item.Kms}}</strong>
      <br />
      {{item.Operation}}
      <br />
      {{MoreText}} {{Operation2}}
    </ul>

    <b-table striped hover :per-page="perPage" :current-page="currentPage" :items="items"></b-table>

    <b-row>
      <b-col md="12" class="my-1 d-flex justify-content-end">
        <b-pagination
          v-model="currentPage"
          :total-rows="items.length"
          :per-page="perPage"
          class="my-0"
        ></b-pagination>
        <b-form-group class="mb-0 ml-2">
          <b-form-select v-model="perPage" :options="pageOptions"></b-form-select>
        </b-form-group>
      </b-col>
    </b-row>
    <div>
      <b-button v-b-toggle.collapse-1 variant="primary">{{descriptionForKms}}</b-button>
      <b-collapse id="collapse-1" class="mt-2">
        <b-card>
          <p class="card-text">Collapse contents Here</p>
          <b-button v-b-toggle.collapse-1-inner size="sm">Toggle Inner Collapse</b-button>
          <b-collapse id="collapse-1-inner" class="mt-2">
            <b-card>Hello!</b-card>
          </b-collapse>
        </b-card>
      </b-collapse>
    </div>
  </div>
</template> 
<script>
export default {
  methods: {
    onSubmit(evt) {
      evt.preventDefault();
      alert(JSON.stringify(this.form));
    },
    send() {
      this.$store
        .dispatch(
          "v1/Vehicles/:Mid/Common-Service-Operations/:service_schedule_id",
          {
            params: {
              countrycode: this.form.countrycode,
              api_key: "w4z6f5c4bxtrpg5dgbjwvux8",
              acceptlanguage: "ru-ru"
            }
          }
        )
        /*        .then(res => {
        var ServiceData = JSON.parse(JSON.stringify(res.data));
          console.log(ServiceData.data.service_intervals);
            for (let i = 0; i < ServiceData.data.service_intervals.length; i++) {
                console.log(ServiceData.data.service_intervals[i]);
           }
        
          });
         
    } */
        .then(res => {
          var ServiceData = JSON.parse(JSON.stringify(res.data));
          console.log(ServiceData.data.service_intervals);
          this.items = ServiceData.data.service_intervals.map(function(i) {
            return {
              Kms: i["interval_description_for_kms"],
              MoreText: i["operations"],
              Operation:
                i["operations"][0].operation_action +
                " - " +
                i["operations"][0].operation_description,

              Description: i["operation_description"],
              Action: i["operation_action"]
            };
          });
        });
    }
  },

  data() {
    return {
      items: Array,
      item: Object,

      items: [
        {
          Number: "",
          To: "",
          Kms: "",
          Operation: "",
          Description: "",
          Action: "",
          OperationID: "",
          MoreText: ""
        }
      ],
      Operation: "" /*  ServiceData.data.service_intervals[i].operations */,
      Operation2: "",
      MoreText: "",
      manufacturers: [],
      descriptionForKms: "",
      Number: "",

      form: {
        countrycode: ""
      },

      totalRows: 1,
      currentPage: 1,
      perPage: 50,
      pageOptions: [5, 10, 15, 50, 100],
      sortBy: null,
      sortDesc: false,
      sortDirection: "asc",
      show: true
    };
  },
  computed: {
    sortOptions() {
      return this.fields
        .filter(f => f.sortable)
        .map(f => {
          return { text: f.label, value: f.key };
        });
    }
  },
  mounted() {
    this.totalRows = this.items.length;
    this.descriptionForKms = this.items.length;
  }
};
</script>
<style>
.border {
  border: 1px solid;
  padding: 20px;
}
</style>


