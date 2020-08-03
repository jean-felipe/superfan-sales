<template>
  <div>
    <div class="header-content beerconsumptions">
      <div class="media-left">
        <p class="card-category">Pedidos</p>
      </div>
      
    </div>

    <div class="card-body" v-if="orders">
      <div v-for="order in orders" v-bind:key="order.id" class="order-card" @click="selectOrder(order)">
        <div class="order-header">
          <h4>#{{ order.order_number }} - {{ order.status }}</h4>
          <h6>Cliente: {{ order.user.name }} - CPF: {{ order.user.document }} - Nome: {{ order.user.name }}</h6>
          <h6>Total: {{ order.total_price }}</h6>

        </div>
       
        <table class="table is-bordered is-striped">
          <tr>
            <th>Nome</th>
            <th>Preço</th>
            <td>Quantidade</td>
          </tr>

          <tbody v-for="item in order.items" v-bind:key="item.id">
            <tr>
              <td>{{ item.product }}</td>
              <td>{{ item.price }}</td>
              <td>{{ item.quantity }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <hr />
    <div class="order-form">
      <div class="order-product-input">
        <label class="label">Cliente</label>
        <input v-model="newItem.identification" class="input is-marginless"/>
      </div>

      <div class="order-product-input">
        <label class="label">Produtos</label>
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
        <button class="button is-success has-magin-bottom" @click="newOrder()">Inserir Pedido</button>
        <button class="button has-magin-bottom" @click="cancel">Cancelar</button>
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
      search: '',
      selectedOrder: {},
      products: [],
      orders: [],
      newItem: {
        items: [],
        identification: '',
        table_id: '',
        code: '',
        id: ''
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

    cancel() {
      window.location = '/saloon'
    },

    getProducts(word) {
      axios.get('/api/v1/products?filter=' + word )
        .then(response => {
          this.products = response.data
          this.productList = true
        })
    },

    addProduct(product) {
      this.newItem.items.push({id: product.id, name: product.name, quantity: 1, price: product.price })
    },

    selectOrder(order) {
      this.selectedOrder = order;
      this.newItem.identification = order.user.document;
      this.newItem.id = order.id;
      this.newItem.code = order.order_number
    },

    newOrder() {
      if (Object.keys(this.selectedOrder).length > 1) {
        axios.patch('/api/v1/orders/' + this.newItem.id, { order: this.newItem})
          .then(response => {
            console.log(response)
          })
      } else {
         axios.post('/api/v1/orders', {order: this.newItem})
        .then((response) => {
          console.log(response)
        })
      }
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
      return this.newItem.items
    }
  },

  mounted() {
    this.newItem.table_id = this.id

    axios.get('/api/v1/tables/' + this.id)
      .then(response => {
        this.orders = response.data.orders;
      })
  }
}
</script>
<style>
.quantity-input {
  width: 30% !important;
  margin-left: 15px !important;
}

.item-quantity {
  margin-top: 10px !important;
}

.order-card {
  padding: 15px;
}

.order-card:hover {
  border: 1px solid black;
  cursor: pointer;
}
</style>