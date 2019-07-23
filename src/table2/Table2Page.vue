<script charset="utf-8">
import FullCalendar from '@fullcalendar/vue'
import resourceTimelinePlugin from '@fullcalendar/resource-timeline'

export default {
  components: {
    FullCalendar
  },
  data() {
    return {
      calendarPlugins: [ resourceTimelinePlugin ]
      
    }
  }
}

</script>

<template>
    <div style="margin:0px 10px;">
        <FullCalendar
                      :plugins="calendarPlugins"
                      defaultView="resourceTimelineDay"
                      locale="uk"
                      nowIndicator="true"
                      :header="{
                        left: 'prev,next today',
                        center: 'title',
                        right: 'resourceTimelineDay,resourceTimelineWeek'
                      }"
                      displayEventTime="true"
                      displayEventEnd="true"
                      :eventTimeFormat="{
                        hour: 'numeric',
                        minute: '2-digit',
                        meridiem: false
                      }"
                      :resources="[
                        {id:'a', title: 'Підйомник 1' },
                        {id:'b', title: 'Підйомник 2' },
                        {id:'c', title: 'Підйомник 3' },
                        {id:'d', title: 'Підйомник 4' }
                      ]"
                      :events="[
                        {
                          id: '1',
                          resourceId: 'a',
                          title: 'Mazda 3 BP455AM',
                          date: '2019-07-22 12:10:00',
                          end: '2019-07-22 18:00:00',
                          textColor:'white',
                          backgroundColor:'#42b983 '
                        },
                        {
                          id: '2',
                          resourceId: 'b',
                          title: 'Mazda 2 BP455AM',
                          date: '2019-07-22 08:00:00',
                          end: '2019-07-22 18:00:00',
                          textColor:'white',
                           backgroundColor:'rgb(88, 218, 156) '
                        },
                        {
                          id: '3',
                          resourceId: 'c',
                          title: 'Mazda 2 BP455AM',
                          date: '2019-07-22 09:00:00',
                          end: '2019-07-22 23:00:00',
                          textColor:'white'
                        },
                        {
                          id: '4',
                          resourceId: 'd',
                          title: 'Mazda 2 BP455AM',
                          date: '2019-07-22 10:00:00',
                          end: '2019-07-22 14:00:00',
                          textColor:'white',
                          backgroundColor:'rgb(255, 194, 10) '
                        },
                        {
                          id: '5',
                          resourceId: 'd',
                          title: 'Mazda 2 BP455AM',
                          date: '2019-07-22 14:30:00',
                          end: '2019-07-22 22:00:00',
                          textColor:'white',
                           backgroundColor:'#ddd '
                        }
                      ]"
                      />
    </div>

</template>

<style lang='scss'>

    @import '~@fullcalendar/core/main.css';
    @import '~@fullcalendar/timeline/main.css';
    @import '~@fullcalendar/resource-timeline/main.css';
    .fc-license-message{
      display: none;
    }
    .fc-divider.fc-col-resizer.fc-widget-header
    {
      height: auto;
    }
    .fc-scroller{
      height: auto !important;
    }
    .fc-timeline .fc-cell-text{
      color: #999;
    text-align: right;
    padding-right: 2px;
    font-size: .9em;
    }
    .fc-button-primary {
    color: #fff;
    background-color: #42b983 !important;
    border-color: #42b983 !important;
}
.fc-right{
  position: absolute;
    width: 100%;
    background-color: #42b983 !important;
   display: flex;
   justify-content: center;
}
.fc-left , .fc-center{
  margin-top: 50px;
}.fc-toolbar.fc-header-toolbar{
  position: relative;
  align-items:flex-start;
}
.fc-event{
  border: none;
}
.fc-button-primary:not(:disabled):active:focus, .fc-button-primary:not(:disabled).fc-button-active:focus{
      border-bottom-width: 2px;
    background: hsla(0,0%,100%,.15);
    color: white;
    box-shadow:none;
}
.fc-resourceTimelineDay-button , .fc-resourceTimelineWeek-button{
padding: .3em 1em;
    height: 2.2em;
    font-size: 1.3em;
    border: none;
    border-bottom: 0 solid currentColor !important;
    cursor: pointer;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    -webkit-transition: .2s;
    transition: .2s;
}
 .fc-center{
  position: absolute;
    display: flex;
    justify-content: center;
    width: 100%;
}
.fc-toolbar.fc-header-toolbar .fc-center h2{
    font-size: 1.4em ;
    line-height: 1.3 ;
    font-weight: 400 ;
    color: #212529;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
}
.fc-toolbar.fc-header-toolbar{
  height: 70px;
}
.fc-left{
      display: flex;
    justify-content: space-between;
    position: absolute;
    width: 100%;
    background-color: #e4f5ef ;
}
.fc-timeline-event.fc-h-event.fc-event.fc-start.fc-end.fc-draggable{
  height: 33px;
}
.fc-time{
  position: relative;
  float: none;
}
.fc-event .fc-content {
    display: flex;
    height: 100%;
    align-items: center;
}

</style>
