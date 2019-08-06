<template>
  <div>
    <b-button v-b-modal.modal-prevent-closing>Open Modal</b-button>

    <div class="mt-3">
      Submitted Names:
      <div v-if="submittedNames.length === 0">--</div>
      <ul v-else class="mb-0 pl-3">
        <li v-for="name in submittedNames">{{ name }}</li>
      </ul>
    </div>

    <b-modal
      id="modal-prevent-closing"
      ref="modal"
      title="Опрацювання заявки :"
      @show="resetModal"
      @hidden="resetModal"
      @ok="handleOk"
    >
      <form ref="form" @submit.stop.prevent="handleSubmit">
        <b-form-group
          :state="nameState"
          label="Name"
          label-for="name-input"
          invalid-feedback="Name is required"
        >
          <b-form-input
            id="name-input"
            v-model="name"
            :state="nameState"
            required
          ></b-form-input>
        </b-form-group>
        <b-form-group id="employeeFirstName" label="Майстер:" label-for="employeeFirstName">
          <b-form-select
            id="employeeFirstName"
            v-model="form.employeeID"
            :options="employeeFirstNames"
             required
          ></b-form-select>
        </b-form-group>
      </form>
    </b-modal>
  </div>
</template>

<script>
  export default {
      created(){
        this.$store.dispatch("GetEmployees",{params:{id:1, id:1}}).then(res =>{
            var vendorData = JSON.parse(JSON.stringify(res.data));
            this.employeeFirstNames=vendorData.map(function(i){
               return{
                    text: i["employeeFirstName"],
                    value:i["employeeID"]
                };
            });
        });
      },
    data() {
      return {
        form:{
        employeeFirstName:"",
        },
        employeeFirstNames:[],  
        name: '',
        nameState: null,
        submittedNames: []
      };
    },
    methods: {
         onSubmit(evt) {
      evt.preventDefault();
      this.$store
      .dispatch("GetEmployees",{
          workShopID:1,
          employeePostID:1,
          employeeFirstName: this.form.employeeFirstName,
          employeeID: this.form.employeeID
      })      
    },



      checkFormValidity() {
        const valid = this.$refs.form.checkValidity()
        this.nameState = valid ? 'valid' : 'invalid'
        return valid
      },
      resetModal() {
        this.name = ''
        this.nameState = null
      },
      handleOk(bvModalEvt) {
        // Prevent modal from closing
        bvModalEvt.preventDefault()
        // Trigger submit handler
        this.handleSubmit()
      },
      handleSubmit() {
        // Exit when the form isn't valid
        if (!this.checkFormValidity()) {
          return
        }
        // Push the name to submitted names
        this.submittedNames.push(this.name)
        // Hide the modal manually
        this.$nextTick(() => {
          this.$refs.modal.hide()
        })
      }
    }
  }
</script>