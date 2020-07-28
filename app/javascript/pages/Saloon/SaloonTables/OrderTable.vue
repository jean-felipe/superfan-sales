<template>
  <div>
    <div class="header-content beerconsumptions">
    <div class="media-left">
      <p class="card-category">Pedidos</p>
    </div>
    
  </div>
    <hr />
    <div class="order-form">
      <div class="order-product-input">
        <label class="label">Cliente</label>
        <input v-model="newItem.identification" class="input is-marginless"/>
      </div>

      <div class="order-product-input">
        <label class="label">Produto</label>
        <input v-model="search" class="input is-marginless" />
      </div>
      <div class="products-list" v-if="productList" >
        <table class="table is-bordered is-striped">
          <tr>
            <th>Nome</th>
            <th>Preço</th>
            <td>Ação</td>
          </tr>

          <tbody v-for="product in products" v-bind:key="product.id">
            <tr>
              <td>{{ product.name }}</td>
              <td>{{ product.price }}</td>
              <td>
                <button class="button is-success has-magin-bottom" @click="addProduct(product)">Adicionar</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      
      <hr />
      
      <div v-if="selectedProducts.length > 0">
        <table class="table is-bordered is-striped">
          <tr>
            <th>Nome</th>
            <th>Quantidade</th>
            <th>Preço</th>
          </tr>
          <tbody v-for="product in selectedProducts" v-bind:key="product.id">
            <tr>
              <td>{{ product.name }}</td>
              <td>
                <input type="number" v-model="product.quantity" class="input is-marginless quantity-input" />
              </td>
              <td>{{ product.price }}</td>
            </tr>
          </tbody>
        </table>
      </div>
      
      <br>
      <div>
        <button class="button is-success has-magin-bottom" @click="newTable()">Inserir Pedido</button>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'OrderTable',

  data() {
    return {
      productList: false,
      products: [],
      search: '',
      items: [],
      newItem: {
        productId: '',
        quantity: '',
        description: '',
        identification: ''
      }
    }
  },

  props: {
    id: {
      type: Number,
      required: true
    }
  },

  methods: {
    handleInput(e) {
      console.log(e)
    },

    getProducts(word) {
      axios.get('/api/v1/products?filter=' + word )
        .then(response => {
          console.log(response.data)
          this.products = response.data
          this.productList = true
        })
    },

    addProduct(product) {
      this.items.push({id: product.id, name: product.name, quantity: 1})
    }
  },

  watch: {
    search: function(val, oldVal) {
      if(val.length > 2) {
        this.getProducts(val)
      }
    }
  },

  computed: {
    selectedProducts() {
      return this.items
    }
  }
}
</script>
<style>
.quantity-input {
  width: 10% !important;
  margin-left: 15px !important;
}

.item-quantity {
  margin-top: 10px !important;

}
</style>