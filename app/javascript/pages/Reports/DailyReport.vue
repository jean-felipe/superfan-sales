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
                </div>

                <div>
                  Filtar por data: <Datepicker v-model="date" />
                </div>
              </div>
            </div>
            <div class="card-body">
              <table class="table is-bordered is-striped">
                <tr>
                  <th>Faturamento total:</th>
                  <td>R$ {{report.total_billing}}</td>
                </tr>
                 <tr>
                  <th>Vendas totais</th>
                  <td>{{report.total_sales}}</td>
                </tr>
                <tr>
                  <th>Faturamento por Meios de pagamento</th>
                  <td>
                    <table class="table is-bordered">
                      <thead>
                        <th>Nome</th>
                        <th>Total</th>
                      </thead>
                      <tbody v-for="(payment, index) in report.total_billing_by_payment_types" v-bind:key="index + payment.name">
                        <tr>
                          <td>
                            {{payment.name}}
                          </td>
                          <td>
                            R$ {{payment.value}}
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </td>
                </tr>
                <tr>
                  <th>Total de vendas por Meios de pagamento</th>
                  <td>
                    <table class="table is-bordered">
                      <thead>
                        <th>Nome</th>
                        <th>Total</th>
                      </thead>
                      <tbody v-for="(payment, index) in report.total_by_payment_types" v-bind:key="index + payment.name">
                        <tr>
                          <td>
                            {{payment.name}}
                          </td>
                          <td>
                            {{payment.value}}
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </td>
                </tr>
                <tr>
                  <th>Faturamento por produtos</th>
                  <td>
                    <table class="table is-bordered">
                      <thead>
                        <th>Nome</th>
                        <th>Total</th>
                      </thead>
                      <tbody v-for="(product, index) in report.total_billing_by_products" v-bind:key="index + product.name">
                        <tr>
                          <td>
                            {{product.name}}
                          </td>
                          <td>
                            R$ {{product.billing}}
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </td>
                </tr>
                <tr>
                  <th>Novos Clientes</th>
                  <td>
                    <table class="table is-bordered">
                      <thead>
                        <th>Nome</th>
                        <th>Items</th>
                        <th>Faturado</th>
                      </thead>
                      <tbody v-for="data in report.total_new_customers" v-bind:key="data.user.id">
                        <tr>
                          <td>
                            {{data.user.name}}
                          </td>
                          <td>
                            {{data.total_items}}
                          </td>
                          <td>
                            R$ {{data.total_billing}}
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </td>
                </tr>
                <tr>
                  <th>Total de produtos vendidos</th>
                  <td>
                    <table class="table is-bordered">
                      <thead>
                        <th>Nome</th>
                        <th>Total</th>
                      </thead>
                      <tbody v-for="(product, index) in report.total_sales_by_products" v-bind:key="index + product.name">
                        <tr>
                          <td>
                            {{product.name}}
                          </td>
                          <td>
                            {{product.billing}}
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </td>
                </tr>
              </table>
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
import Datepicker from 'vuejs-datepicker';

export default {
  name: 'DailyReport',
  components: { Datepicker },

  data() {
    return {
      headers: ['#', 'Status', 'Preço Total', 'Cliente', 'Meio de pagamento', 'Data'],
      report: {},
      date: ''
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
        this.report = response.data
      })
  }
}
</script>

<style>

</style>
