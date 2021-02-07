<template>
  <ul class="menu">
    <li class="menu-item">
      <a class="menu-link" @click="goToDailyReport()">
        <i class="fas fa-calendar-check"></i>
        <p class="title is-4 has-text-white">Resumo do dia</p>
      </a>
    </li>    
  </ul>
</template>

<script>
export default {
  name: 'CommonLinks',

  data() {
    return {
      name: ''
    }
  },

  methods: {
    goToDailyReport() {
      window.location.href = '/daily-report';
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

    goToClients() {
      window.location.href = '/clients';
    },
  },
}
</script>

<style>
  

</style>
