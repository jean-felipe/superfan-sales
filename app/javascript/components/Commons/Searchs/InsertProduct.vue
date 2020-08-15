<template>
  <div class="insert-product">
    <div class="inputs">
      <input type="text" v-model="search" class="input is-marginless">
      <input type="number" v-model="product.quantity">
      <button class="button is-success" @click="addProduct()">Inserir</button>
    </div>
    <div class="select-products" v-if="productList">
      <select v-model="product.id">
        <option v-for="product in products" v-bind:key="product.value" v-bind:value="product.id">
          {{ product.name }} - {{ product.price }}
        </option>
      </select>
    </div>
  </div>
</template>

<script>
export default {
  name: "InsertProduct",

  props: {
    orderId: {
      type: String
    }
  },

  data() {
    return {
      search: '',
      products: [],
      productList: false,
      product: {
        id: '',
        quantity: ''
      }
    }
  },

  methods: {
    getProducts(word) {
      axios.get('/api/v1/products?filter=' + word )
        .then(response => {
          this.products = response.data
          this.productList = true
        })
    },

    addProduct(product) {
      axios.patch('/api/v1/orders/' + this.orderId, this.product)
        .then(response => {
          console.log(response)
        })
    },
  },

  watch: {
    search: function(val, oldVal) {
      if(val.length > 2) {
        this.getProducts(val)
      }
    }
  },
}
</script>