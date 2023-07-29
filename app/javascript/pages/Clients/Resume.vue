<template>
  <div>
    <div>
      <Table
        :headers="birthdateHeaders"
        :elements="birthdates"
        v-if="birthdates.length > 0"
      />

      <p v-if="birthdates.length === 0">Sem aniversariantes hoje</p>
    </div>

    <Table
      :headers="birthdateHeaders"
      :elements="subscriptions"
      v-if="subscriptions.length > 0"
    />

    <p v-if="subscriptions.length === 0">Sem assinaturas vencendo nos proximos 5 dias</p>


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
      birthdateHeaders: ['Nome', 'Data'],
      birthdates: [],
      subscriptions: []
    }
  },

  props: {
    data: {
      type: Object
    }
  },

  mounted() {
    axios.get('/api/v1/customer-resume')
      .then(response => {
        this.birthdates.push(response.data.birthdates)
        this.subscriptions.push(response.data.subscribers)
      })
  }

}
</script>
<style>

</style>
