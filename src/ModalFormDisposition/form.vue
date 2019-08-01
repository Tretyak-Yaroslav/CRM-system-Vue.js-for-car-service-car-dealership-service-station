<template>
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
</template>
