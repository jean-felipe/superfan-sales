<template>
  <ul class="menu">
    <li class="menu-item">
      <a class="menu-link" @click="goToProducts()">
        <i class="fas fa-boxes"></i>
        <p class="title is-4 has-text-white">Produtos</p>
      </a>
    </li>
    <li class="menu-item">
      <a class="menu-link" @click="goToOrders()">
        <i class="fas fa-clipboard-list"></i>

        <p class="title is-4 has-text-white">Pedidos</p>
      </a>
    </li>
    <li class="menu-item">
      <a class="menu-link" @click="goToServices()">
        <i class="fas fa-clipboard-list"></i>

        <p class="title is-4 has-text-white">Serviços</p>
      </a>
    </li>
    <li class="menu-item">
      <a class="menu-link" @click="goToClients()">
        <i class="fas fa-users"></i>
        <p class="title is-4 has-text-white">Clientes</p>
      </a>
    </li>
    <li class="menu-item">
      <a class="menu-link" @click="goToClients()">
        <i class="fas fa-play-circle"></i>
        <p class="title is-4 has-text-white">Fidelidade</p>
      </a>
    </li>

  </ul>
</template>

<script>
export default {
  name: 'MarketLinks',

  data() {
    return {
      name: ''
    }
  },

  methods: {
    goToProducts() {
      window.location.href = '/products';
    },

    goToStock() {
      window.location.href = '/stocks';
    },

    goToHome() {
      window.location.href = '/';
    },

    goToOrders() {
      window.location.href = '/orders';
    },

    goToCheckouts() {
      window.location.href = '/checkouts';
    },

    goToServices() {
      window.location.href = '/service_definitions';
    },

    goToClients() {
      window.location.href = '/clients';
    },
  },
}
</script>

<style>


</style>
