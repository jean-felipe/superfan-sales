<template>
  <div class="card table-widget" :class="{ 'free': table.status == 'Livre', 'not-free': table.status == 'Ocupada' }">
    <div class="widget-header" @click="goToTable()">
      <ul class="widget-list">
        <li>Nome: {{table.name}}</li>
        <li>Lugares: {{table.places}}</li>
        <li>{{table.status}}</li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SaloonTable',

  data() {
    return {
      cardClass: '',
      table: {
        id: '',
        name: '',
        places: '',
        status: '',
        timer: ''
      }
    }
  },

  props: {
    info: {
      type: Object,
      required: true
    }
  },

  methods: {
    goToTable(e) {
      this.$emit('clicked', this.table.id)
    }
  },

  mounted() {
    this.table.name = this.info.name
    this.table.status = this.info.status
    this.table.places = this.info.places
    this.table.id = this.info.id
    console.log(this.info)
  }
}
</script>

<style scoped>
.table-widget {
  width: 200px;
  margin-right: 30px;
  margin-bottom: 30px;
  padding: 10px;
}

.table-widget:hover {
  border: 1px black solid;
  cursor: pointer;
}

.widget-list {
  list-style: none;
  margin: 0;
}

.free {
  background-color: #48c774;
  color: #fff;
  border: 1px solid transparent;
  border-radius: 4px;
}

.not-free {
  background-color: #f14668;
  border-color: transparent;
  color: #fff;
  border-radius: 4px;
}
</style>