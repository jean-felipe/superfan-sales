<template>
  <ul class="menu">
    <li class="menu-item">
      <a class="menu-link" @click="goToProducts()">
        <i class="fas fa-boxes"></i>
        <p class="title is-4 has-text-white">Produtos</p>
      </a>
    </li>
    <li class="menu-item">
      <a class="menu-link" @click="goToSaloon()">
        <i class="fas fa-utensils"></i>
        
        <p class="title is-4 has-text-white">Mesas</p>
      </a>
    </li>
    <li class="menu-item">
      <a class="menu-link" @click="goToOrders()">
        <i class="fas fa-briefcase"></i>
        <p class="title is-4 has-text-white">Pedidos</p>
      </a>
    </li>
      <li class="menu-item">
      <a class="menu-link" @click="goToClients()">
        <i class="fas fa-users"></i>
        <p class="title is-4 has-text-white">Clientes</p>
      </a>
    </li>
    <li class="menu-item">
      <a class="menu-link" @click="goToCheckouts()">
        <i class="fas fa-play-circle"></i>
        <p class="title is-4 has-text-white">Frente de caixa</p>
      </a>
    </li>
    
  </ul>
</template>

<script>
export default {
  name: 'RestaurantLinks',

  data() {
    return {
      name: ''
    }
  },

  methods: {
    goToProducts() {
      window.location.href = '/products';
    },

    goToHome() {
      window.location.href = '/';
    },

    goToSaloon() {
      window.location.href = '/saloon';
    },

    goToOrders() {
      window.location.href = '/orders';
    },

    goToCheckouts() {
      window.location.href = '/checkouts';
    },

    goToClients() {
      window.location.href = '/clients';
    },

    goToTimes() {
      window.location.href = '/times';
    }
  },

  created() {
    this.name = this.user.user.name;
  }
}
</script>

<style>



</style>
