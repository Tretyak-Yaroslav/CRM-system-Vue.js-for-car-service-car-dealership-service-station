<template>
<b-container fluid class="bv-example-row">
<vue-cal selected-date="2018-11-19"
          small
         :time-from="9 * 60"
         :time-to="21 * 60"
         today-button
         default-view="week"
         :disable-views="['years', 'year', 'month']"
         :on-event-click="onEventClick"
         :no-event-overlaps="true"
         hide-weekends
         :events="events"
         locale ="uk"
         >

</vue-cal>
 <b-modal  v-model="showDialog">
   <div class="form-group">
    <label class="control-label">Статус</label>
    <select class="form-control order-status" name="order[status]">
        <option selected="selected" value="new_order">Новий</option>
          <option value="processed">Опрацьовано</option>
          <option value="verified">Підтверджено</option>
          <option value="rewrite">Скасовано</option></select>
        </div>
     <div class="form-group">
     <label class="control-label">Мастер</label>
     <select name="order[details_attributes][0][serviceman_id]" id="order_details_attributes_0_serviceman_id" class="form-control slot-select"><option value="" label=" "></option></select>
    </div>
   <div class="form-group">
    <label class="control-label">Слюсар</label>
    <select name="order[details_attributes][0][serviceman_id]" id="order_details_attributes_0_serviceman_id" class="form-control slot-select"><option value="" label=" "></option></select>
    </div>  
     <div class="col-md-6 if-available left">
        <div class="form-group">
         <label class="control-label">Имя</label>
         <input placeholder="Введите имя" class="form-control" type="text" name="order[name]" id="order_name">
        </div>
    </div> 
     <div class="col-md-6 if-available right">
      <div class="form-group">
      <label class="control-label">Телефон</label>
       <input type="tel" class="form-control" name="phone" id="" placeholder="+380960547903">
        </div>
      </div> 
     
    <b-button class="mt-3" block @click="$bvModal.hide('show-information')">Закрить</b-button>
  <v-card>
    <v-card-title>
      <v-icon>{{ selectedEvent.icon }}</v-icon>
      <span>{{ selectedEvent.title }}</span>
      <v-spacer/>
      <strong>{{ selectedEvent.startDate }}</strong>
    </v-card-title>
    <v-card-text>
      <p v-html="selectedEvent.contentFull"/>
      <strong>Деталі події :</strong>
      <ul>
        <li>Подія починається з: {{ selectedEvent.startTime }}</li>
        <li>Подія закінчується о: {{ selectedEvent.endTime }}</li>
      </ul>
    </v-card-text>  
  </v-card> 
</b-modal > 

</b-container>    
</template>

<style>
.vuecal__event {cursor: pointer;}
.vuecal__event-title {
  font-size: 1.2em;
  font-weight: bold;
  margin: 4px 0 8px;
}
.vuecal__now-line 
{display: inline;
  color: #06c !important;}
.vuecal__event-time {
  display: inline-block;
  margin-bottom: 12px;
  padding-bottom: 12px;
  border-bottom: 1px solid #42b983;
}
ul {
    margin-top: 0;
    margin-bottom: 0!important;
}
.vuecal__menu{
background-color: #42b983 !important;
}
.vuecal__flex vuecal__menu li{
  color: white;
}
.vuecal__flex .vuecal__weekdays-headings{
  display: none !important;
}
.vuecal__menu li.active{
 
      color: white;
}
.vuecal__event-content {
  font-style: italic;
} 
.vuecal__title-bar {background-color: #e4f5ef !important;}
.modal-backdrop {
    opacity: 0.5;
}

</style>

<script>
export default {
 
  components: { 'vue-cal': vuecal },
  data: () => ({
  selectedEvent: {},
  showDialog: false,
  events: [
    {
      start: '2018-11-19 9:25',
      end: '2018-11-19 11:45',
      title: 'Mazda 3  ВР455АМ',
      content: 'Заміна Led ламп',
      contentFull: 'Потрібно зробить <ul> <li> замінить лампи ближнього свету</li> <li>заміна стойок</li> <li>корекція фар</li></ul>    ', // Custom attribute.
      class: 'lunch',
    
    },
    {
      start: '2018-11-20 13:25',
      end: '2018-11-20 18:00',
      title: 'Kia sportage  AA7903ВР',
      content: 'Заміна Led ламп',
      contentFull: 'Потрібно зробить <ul> <li> замінить лампи ближнього свету</li> <li>заміна стойок</li> <li>корекція фар</li></ul>    ', // Custom attribute.
      class: 'lunch',
    
    },
    {
      start: '2018-11-20 14:00',
      end: '2018-11-20 18:22',
      title: 'Golf 5 АА5564СВ',
      content: 'Заміна пильника ',
      contentFull: 'Потрібно зробить <ul> <li> замінить лампи ближнього свету</li> <li>заміна стойок</li> <li>корекція фар</li></ul>    ', // Custom attribute.
      class: 'leisure',
     
    },
    {
      start: '2018-11-22 10:00',
      end: '2018-11-22 15:00',
      title: 'Golf 5 АА5564СВ',
      content: 'Заміна пильника ',
      contentFull: 'Потрібно зробить <ul> <li> замінить лампи ближнього свету</li> <li>заміна стойок</li> <li>корекція фар</li></ul>    ', // Custom attribute.
      class: 'leisure'
    }
  ]
}),
methods: {
  onEventClick (event, e) {
    this.selectedEvent = event
    this.showDialog = true

    // Prevent navigating to narrower view (default vue-cal behavior).
    e.stopPropagation()
  }
}

} 
</script>


<!-- <b-modal id="show-information" hide-footer>
    <template slot="modal-title">
     <strong>Управління</strong> заявкою
    </template>
    
    <div class="form-group">
    <label class="control-label">Статус</label>
    <select class="form-control order-status" name="order[status]">
        <option selected="selected" value="new_order">Новий</option>
          <option value="processed">Опрацьовано</option>
          <option value="verified">Підтверджено</option>
          <option value="rewrite">Скасовано</option></select>
        </div>
     <div class="form-group">
     <label class="control-label">Мастер</label>
     <select name="order[details_attributes][0][serviceman_id]" id="order_details_attributes_0_serviceman_id" class="form-control slot-select"><option value="" label=" "></option></select>
    </div>
   <div class="form-group">
    <label class="control-label">Слюсар</label>
    <select name="order[details_attributes][0][serviceman_id]" id="order_details_attributes_0_serviceman_id" class="form-control slot-select"><option value="" label=" "></option></select>
    </div>  
     <div class="col-md-6 if-available left">
        <div class="form-group">
         <label class="control-label">Имя</label>
         <input placeholder="Введите имя" class="form-control" type="text" name="order[name]" id="order_name">
        </div>
    </div> 
     <div class="col-md-6 if-available right">
      <div class="form-group">
      <label class="control-label">Телефон</label>
       <input type="tel" class="form-control" name="phone" id="" placeholder="+380960547903">
        </div>
      </div> 
     
    <b-button class="mt-3" block @click="$bvModal.hide('show-information')">Закрить</b-button>
  </b-modal> -->

<!-- Vue Cal -->