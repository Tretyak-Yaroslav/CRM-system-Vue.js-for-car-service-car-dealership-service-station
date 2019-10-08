<template src="./DetailsTable.html"/>
<script>
import moment from "moment";
import BootstrapVue from 'bootstrap-vue';
import "moment/locale/uk";
export default {
   props: {
     items : null
   },
  components: {
    BootstrapVue
  },
  data() {
    return {
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
          sortable: true
        },
        {
          key: "modelAndMakeCar",
          label: "Автомобіль",
          sortable: true
        },
        {
          key: "employeeMaster",
          label: "Майстер-приймальник",
          sortable: true,
          sortDirection: "desc"
        },
        { key: "actions", label: "Керування" }
      ],
      totalRows: Number,
      currentPage: 1,
      perPage: 10,
      pageOptions: [5, 10, 15, 50, 100],
      sortBy: "DateTime",
      sortDesc: true,
      sortDirection: "asc",
      filter: null,
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

  methods: {
  saveQuery(item, isDeleted) {
    item.endTime = moment(item.endTime).format("YYYY-MM-DD HH:mm:ss");
    item.startTime = moment(item.startTime).format("YYYY-MM-DD HH:mm:ss");
console.log(item);
  if (confirm('Бажаєте видалити заявку '+item.queryID+'?')) {
          this.$parent.saveQuery(item, false, isDeleted, 
          () => { },
          (error) =>{ })
      }
  },
  loadForm(id){
  this.$parent.createModalInstance('modal-edit',null,id,this.$parent.date1,this.$parent.date2)
    },

  exportQueryCSV(id) {
      this.$store
        .dispatch("ExportQueryToFile", {
          params: {
            from: this.$parent.date1,
            to: this.$parent.date2,
            workShopID: 1,
            queryStatusID: 0,
            notShortQuery: 0,
            queryID: id
          }
        })
        .then(res => {
            var queryData = JSON.parse(JSON.stringify(res.data));
            if (res.status == 200) {
                alert("Заявка успішно завантажена");
            }
            else {
                alert("Помилка! Заявка не завантажена")
            }
        });
    }
  }
};
</script>
 <style lang="scss">
    @import "DetailsTable.scss";
</style>
