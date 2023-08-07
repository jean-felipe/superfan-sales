<template>
  <div>
    <div>
      Aniversariantes:
      <Table
        :headers="birthdateHeaders"
        :elements="loadBirthdates"
      />
    </div>

    <br />

    Assinaturas
    <Table
      :headers="subscribersHeaders"
      :elements="loadSubscribers"
    />


  </div>
</template>
<script>
import axios from 'axios';

import Table from '../../components/Commons/Table/Table.vue';

export default {
  name: 'Resume',
  components: { Table },

  data() {
    return {
      birthdateHeaders: ['#', 'Nome', 'Email', 'Genero', 'Documento', 'Aniversario'],
      subscribersHeaders: ['#', 'Serviço', 'Cliente', 'Vencimento'],
      birthdates: [],
      subscriptions: []
    }
  },

  props: {
    data: {
      type: Object
    }
  },

  computed: {
    loadBirthdates() {
      return this.birthdates
    },

    loadSubscribers() {
      return this.subscriptions
    }
  },

  mounted() {
    axios.get('/api/v1/customer-resume')
      .then(response => {
        this.birthdates = response.data.birthdates
        this.subscriptions = response.data.subscribers
      })
  }

}
</script>
<style>

</style>
