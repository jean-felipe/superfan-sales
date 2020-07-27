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
        <label class="label">Inserir</label>
        <input v-model="search" class="input is-marginless" />
      </div>
      
      <div class="products-list" v-if="productList" >
        <ul v-for="product in products" v-bind:key="product.id">
          <li>{{ product.name }}  <input class="input is-marginless" /></li>
        </ul>
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
   
  }
}
</script>