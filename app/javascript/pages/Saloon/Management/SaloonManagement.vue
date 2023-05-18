<template>
 <div>
  <div class="header-content beerconsumptions">
    <div class="media-left">
      <p class="card-category">Gerenciamento de mesas</p>
    </div>
    
    <div>
      <button class="button is-success has-magin-bottom" @click="newTable()">Cadastro de Mesa</button>
    </div>
  </div>
  <Table :headers="tableHeaders" :elements="data" url="/tables"/>
 </div>
</template>

<script>

import Table from '../../../components/Commons/Table/Table.vue';
export default {
  name: 'SaloonManagement',
  components: { Table },

  data() {
    return {
      tableHeaders: ['#', 'Nome', 'Lugares', 'Status', 'Criado em'],
      data: [],
    }
  },

  props: {
    tables: {
      type: Array,
      required: true
    }
  },

  mounted() {
    this.data = this.tables
  },

  methods: {
    newTable() {
      window.location = 'tables/new'
    }
  }


}
</script>

<style scoped>
.has-magin-bottom {
  margin-bottom: 20px;
}
</style>
