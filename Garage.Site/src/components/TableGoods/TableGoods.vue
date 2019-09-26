<template src="./tableGoods.html"></template>
<script>
export default {
  filters: {
    money2: value =>
      new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR"
      }).format(value)
  },

  data() {
    return {
      editindex2: null,
      originalData2: null,
      itemss: [
        {
          code: "111",
          name: "Cuka",
          description: "Cuka mahal",
          qty: 1,
          unit2: null,
          price: 3500,
          discount: 10
        },
        {
          code: "222",
          name: "Kubis",
          description: "Kubis enak",
          qty: 2,
          unit2: null,
          price: 5000,
          discount: 2
        }
      ],
      tax: 10,
      text: "",
      items: "",
      index2: ""
    };
  },

  methods: {
    add2() {
      this.originalData2 = null;
      this.itemss.push({
        code: "",
        name: "",
        description: "",
        qty: 1,
        unit2: 1,
        price: 0,
        discount: 0
      });
      this.editindex2 = this.itemss.length - 1;
    },

    edit(items, index2) {
      this.originalData2 = Object.assign({}, items);
      this.editindex2 = index2;
    },

    cancel(items) {
      this.editindex2 = null;

      if (!this.originalData2) {
        this.itemss.splice(this.itemss.indexOf(items), 1);
        return;
      }

      Object.assign(items, this.originalData2);
      this.originalData2 = null;
    },

    remove(items, index2) {
      this.itemss.splice(index2, 1);
    },
    save(items) {
      this.originalData2 = null;
      this.editindex2 = null;
    },
    subtotal2(items) {
      return (
        items.qty * items.price -
        (items.qty * items.price * items.discount) / 100
      );
    }
  },
  computed: {
    allsubtotal2() {
      return this.itemss
        .map(items => this.subtotal2(items))
        .reduce((a, b) => a + b, 0);
    },
    total() {
      return this.tax
        ? this.allsubtotal2 + this.allsubtotal2 * (this.tax / 100)
        : this.allsubtotal2;
    }
  }
};
</script>
<style>
input[type="number"] {
  text-align: right;
}
.table th {
  padding: 0.5rem !important;
  text-align: center;
}
</style>
