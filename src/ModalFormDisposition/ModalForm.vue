
<template>
  <div>
    <b-button v-b-modal.modal-center>Open Modal</b-button>
    <!-- Innet text vodal to Dom -->
    <!-- <div class="mt-3">
      Submitted Names:
      <div v-if="submittedNames.length === 0">--</div>
      <ul v-else class="mb-0 pl-3">
        <li v-for="name in submittedNames">{{ name }}</li>
      </ul>
    </div>
    -->
    <b-modal id="modal-center" ref="modal" title="Опрацювання заявки :" @show="resetModal" @hidden="resetModal" @ok="handleOk">
      <!-- Innet text vodal to Dom -->
      <!--   <form ref="form" @submit.stop.prevent="handleSubmit">
        <b-form-group
          :state="nameState"
          label="Name"
          label-for="name-input"
          invalid-feedback="Name is required"
        >
          <b-form-input id="name-input" v-model="name" :state="nameState" required></b-form-input>
      </b-form-group>-->
      <div class="form-group">
        <label class="control-label">Статус</label>
        <select class="form-control order-status" name="order[status]">
          <option selected="selected" value="new_order">Новий</option>
          <option value="processed">Опрацьовано</option>
          <option value="verified">Підтверджено</option>
          <option value="rewrite">Скасовано</option>
        </select>
      </div>
      <div class="form-group">
        <label class="control-label">Мастер</label>
        <select
          name="order[details_attributes][0][serviceman_id]"
          id="order_details_attributes_0_serviceman_id"
          class="form-control slot-select"
        >
          <option value label=" "></option>
        </select>
      </div>
      <div class="form-group">
        <label class="control-label">Слюсар</label>
        <select
          name="order[details_attributes][0][serviceman_id]"
          id="order_details_attributes_0_serviceman_id"
          class="form-control slot-select"
        >
          <option value label=" "></option>
        </select>
      </div>
      <div class="row">
        <div class="col-6 if-available left">
          <div class="form-group">
            <label class="control-label">Ім'я:</label>
            <input
              placeholder="Введіть ім'я"
              class="form-control"
              type="text"
              name="name"
              id="CustomerFullName"
            />
          </div>
        </div>
        <div class="col-6 if-available right">
          <div class="form-group">
            <label class="control-label">Телефон</label>
            <input type="tel" class="form-control" name="phone" id placeholder="+380960547444" />
          </div>
        </div>
        <div class="datatime">
          <label class="control-label">Початок роботи</label>
          <datetime type="datetime" v-model="datetimefrom" format="yyyy-MM-dd HH:mm:ss"></datetime>
        </div>
        <div class="datatime">
          <label class="control-label">Закінчення роботи</label>
          <datetime type="datetime" v-model="datetimeto" format="yyyy-MM-dd HH:mm:ss"></datetime>
        </div>
      </div>

    </b-modal>
    <p>{{ $t('message.hello', { msg: 'hello' }) }}</p>
  </div>
</template>

<script>
import { Datetime } from "vue-datetime";
import { Settings } from "luxon";

Settings.defaultLocale = "uk";
const messages = {
  en: {
    message: {
      hello: '{msg} world'
    }
  },

  uk:{
    message:{
      hello:'{msg} світ'
    }
  }
}
// Create VueI18n instance with options
const i18n = new VueI18n({
  locale: 'uk', // set locale
  messages, // set locale messages
})


// Create a Vue instance with `i18n` option
new Vue({ i18n }).$mount('#app')

// Now the app has started!
export default {
  data() {
    return {
      name: "",
      nameState: null,
      submittedNames: []
    };
  },
  methods: {
    checkFormValidity() {
      const valid = this.$refs.form.checkValidity();
      this.nameState = valid ? "valid" : "invalid";
      return valid;
    },
    resetModal() {
      this.name = "";
      this.nameState = null;
    },
    handleOk(bvModalEvt) {
      // Prevent modal from closing
      bvModalEvt.preventDefault();
      // Trigger submit handler
      this.handleSubmit();
    },
    handleSubmit() {
      // Exit when the form isn't valid
      if (!this.checkFormValidity()) {
        return;
      }
      // Push the name to submitted names
      this.submittedNames.push(this.name);
      // Hide the modal manually
      this.$nextTick(() => {
        this.$refs.modal.hide();
      });
    }
  }
};
</script>
<style>
.modal-backdrop {
  opacity: 0.5;
}
.vdatetime-popup {
  font-family: -webkit-body !important;
  position: absolute !important;
  line-height: 1.5 !important;
}
.datatime {
  width: 49%;
  padding: 0 15px;
}
input.vdatetime-input {
  padding: 5px 10px;
width: 100% !important;
  border-radius: 3px;
}

</style>
