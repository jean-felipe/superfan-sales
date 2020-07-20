<template>
  <div>
    <div class="header-content beerconsumptions">
    <div class="media-left">
      <p class="card-category">Pedidos</p>
    </div>
    
    <div>
      <button class="button is-success has-magin-bottom" @click="newTable()">Inserir Pedido</button>
    </div>
  </div>
    <hr />
    <div class="order-form">
      Inserir:
      <input v-model="newItem.productId" />
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'OrderTable',

  data() {
    return {
      newItem: {
        productId: '',
        quantity: '',
        description: ''
      }
    }
  },

  props: {
    id: {
      type: Number,
      required: true
    }
  },

  mounted() {
    axios.get('/api/v1/tables/' + this.id)
      .then((response) => {
        console.log(response)
      })
  }
}
</script>