<style src="./style.css">

</style>
<template src="./order.html"></template>
<script>
export default {
    name: 'Uhuy',

  filters: {
    money: (value) => new Intl.NumberFormat('id-ID', { style: 'currency', currency: 'IDR' }).format(value)
  },

  data() {
    return {
       editIndex: null,
      originalData: null,
      items: [
        { status: 'Завершено', time: '2019-09-24 16:00', servise: 'Ролики навісного обл.',text:'Ролики навысн обл', number: '1,200 ',number2: '1,200', price: '300,00',nds:"20", suma:'360,00',discount:'0', discount2:'0',sumaprice:'60,00',procent:'20%', everything:'360,00', discount: 10, },
        { status: 'Завершено', time: '2019-09-24 16:00', servise: 'Ролики навісного обл.',text:'Ролики навысн обл', number: '1,200 ',number2: '1,200', price: '300,00',nds:"20", suma:'360,00',discount:'0', discount2:'0',sumaprice:'60,00',procent:'20%', everything:'360,00', discount: 10, },
        { status: 'Завершено', time: '2019-09-24 16:00', servise: 'Ролики навісного обл.',text:'Ролики навысн обл', number: '1,200 ',number2: '1,200', price: '300,00',nds:"20", suma:'360,00',discount:'0', discount2:'0',sumaprice:'60,00',procent:'20%', everything:'360,00', discount: 10, },

      ],
      tax: 20,
      selected: null,
      options: [
        { value: null, text: "Please select an option" },
        { value: "a", text: "This is First option" }
      ]
    };
  },
   methods: {

    add() {
      this.originalData = null
      this.items.push({ code: '', name: '', description: '', qty: 1, unit: 1, price: 0, discount: 0 })
      this.editIndex = this.items.length - 1
    },

    edit(item, index) {
      this.originalData = Object.assign({}, item)
      this.editIndex = index
    },

    cancel(item) {
      this.editIndex = null

      if (!this.originalData) {
        this.items.splice(this.items.indexOf(item), 1)
        return
      }

      Object.assign(item, this.originalData)
      this.originalData = null
    },

    remove(item, index) {
      this.items.splice(index, 1)
    },

    save(item) {
      this.originalData = null
      this.editIndex = null
    },

    subtotal(item) {
      return (item.qty * item.price) - (item.qty * item.price * item.discount / 100)
    }

  },

  computed: {

    allSubTotal() {
      return this.items
        .map(item => this.subtotal(item))
        .reduce((a, b) => a + b, 0)
    },

    total() {
      return this.tax
        ? this.allSubTotal + (this.allSubTotal * (this.tax / 100))
        : this.allSubTotal
    }

  },
};
</script>