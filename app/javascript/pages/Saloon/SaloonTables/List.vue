<template>
  <div class="saloon">
    <div class="saloon-tables" v-if="!order">
      <div v-for="table in saloonTables" v-bind:key="table.id">
        <Table :info="table" @clicked="showTable"/>
      </div>
    </div>

    <div class="order-form" v-if="order">
      <OrderTable :id="id" />
    </div>
  </div>
</template>

<script>
import Table from  './SaloonTable';
import OrderTable from './OrderTable';

export default {
  name: 'ListSaloonTables',
  components: { Table, OrderTable },

  data() {
    return {
      order: false,
      id: '',
      saloonTables: []
    }
  },

  props: {
    tables: {
      type: Array,
      required: true
    }
  },

  methods: {
    showTable(id) {
      this.id = id;
      this.order = true;
    }
  },

  mounted() {
    this.saloonTables = this.tables
    console.log(this.tables)
  }
}
</script>

<style scoped>
.saloon-tables {
  display: flex;

  flex-wrap: wrap;
}
</style>