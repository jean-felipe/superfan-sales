<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-md-12">
          <div class="card-content">
            <div class="media">
              <div class="header-content beerconsumptions">
                <div class="media-left">
                  <h4 class="card-title mt-0">Resumo diário</h4>
                  <p class="card-category">Relatorio diário</p>
                </div>

                <div>
                  <!-- <button class="button is-success" @click="newOrder()">Novo Pedido</button> -->
                </div>
              </div>
            </div>
            <div class="card-body">
            </div>
            
            <div>

            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'DailyReport',

  data() {
    return {
      headers: ['#', 'Status', 'Preço Total', 'Cliente', 'Meio de pagamento', 'Data'],
      report: {}
    }
  },

  props: {
    data: {
      type: Array
    }
  },

  methods: {
    newOrder() {
      window.location.href = '/orders/new';
    },
    editOrder(id) {
      window.location = '/orders/' + id
    },
    excludeOrder() {

    },
  },
  
  mounted() {
    axios.get('/api/v1/daily-report')
      .then(response => {
        console.log(response)
      })
  }
}
</script>

<style>

</style>