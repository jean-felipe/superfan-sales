<template>
  <ul class="menu">
    <li class="menu-item">
      <a class="menu-link" @click="goToDailyReport()">
        <i class="fas fa-calendar-check"></i>
        <p class="title is-4 has-text-white">Resumo do dia</p>
      </a>
    </li>
    <li class="menu-item">
      <a class="menu-link" @click="goToAccount()">
        <i class="fas fa-home"></i>
        <p class="title is-4 has-text-white">Seu Estabalecimento</p>
      </a>
    </li>
    <li class="menu-item" v-if="user.user.role === 'admin'">
      <a class="menu-link" @click="goToAdminClients()">
        <i class="fas fa-user-cog"></i>
        <p class="title is-4 has-text-white">Administrativo</p>
      </a>
    </li>
  </ul>
</template>

<script>
export default {
  name: 'CommonLinks',

  data() {
    return {
      name: '',
      currentUser: {},
      company: {}
    }
  },

  props: {
    user: {
      type: Object,
    }
  },

  methods: {
    goToDailyReport() {
      window.location.href = '/daily-report';
    },

    goToAdminClients() {
      window.location.href = '/admin';
    },

     goToAccount() {
      window.location.href = '/companies/' + this.currentUser.company.id;
    },
  },

  mounted() {
    this.currentUser = this.user;
    this.company = this.user.company;
  }
}
</script>

<style>


</style>
