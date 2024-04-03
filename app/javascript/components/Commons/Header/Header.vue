<template>
  <nav class="navbar">

        <div class="navbar-end">
          <div class="navbar-item">
            <div class="buttons">
               <button class="bd-tw-button button">
                  <span class="icon">
                    <i class="fas fa-bell"></i>
                  </span>
                </button>

                <a class="bd-tw-button button" @click="goToAccount()">
                  <span class="icon">
                    <i class="fas fa-user-circle"></i>
                  </span>
                  <span>
                    Conta
                  </span>
                </a>

                <a class="button is-danger" @click="logout()">
                  <span class="icon">
                    <i class="fas fa-sign-in-alt"></i>
                  </span>
                  <span>Sair</span>
                </a>
            </div>
            <div class="field is-grouped">
              <div class="notification is-warning" v-if="company == null">
                <button class="delete"></button>
                Você precisa criar seu Estabalecimento, <a @click="goToCreateCompany()">clique aqui</a>
              </div>

            </div>
          </div>
        </div>
  </nav>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Header',

  data() {
    return {
      currentUser: {},
      company: {}
    }
  },

  methods: {
    logout(e) {
      const csrfToken = document.querySelector("meta[name=csrf-token]").content
      axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
      axios.delete('/users/sign_out')

      window.location.href = '/';
    },

    goToHome() {
      window.location.href = '/';
    },

    goToCreateCompany() {
      window.location.href = '/companies/new'
    }

  },

  props: {
    user: {
      type: Object,
    }
  },

  mounted() {
    console.log('aqowieuqoiwueoqiweu')
    this.currentUser = this.user;
    this.company = this.user.company;
  }
}
</script>

<style>

</style>
