<template>
  <div class="insert-product">
   <div class="order-product-input">
        <input v-model="search" placeholder="Pesquise produtos" class="input is-marginless" />
      </div>
      <div class="products-list" v-if="productList" >
        <table class="table is-bordered is-striped">
          <tr>
            <th>Nome</th>
            <th>Preço</th>
            <th>Quantidade</th>
            <td>Ação</td>
          </tr>

          <tbody v-for="product in products" v-bind:key="product.id">
            <tr>
              <td>{{ product.name }}</td>
              <td>{{ product.price }}</td>
              <td><input type="number" v-model="product.quantity" /></td>
              <td>
                <button class="button is-success has-magin-bottom" @click="addProduct(product)">Adicionar</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: "InsertProduct",

  props: {
    orderId: {
      type: Number
    }
  },

  data() {
    return {
      search: '',
      products: [],
      productList: false,
      quantity: '',
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
      let item = {
        id: product.id,
        name: product.name,
        quantity: product.quantity,
        price: product.price,
      }

      axios.patch('/api/v1/orders/' + this.orderId, {order: {items: [item]}})
        .then(response => {
          document.location.reload(true);
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

<style>
.insert-product {
  width: 400px;
}
</style>