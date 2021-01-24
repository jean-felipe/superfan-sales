<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-md-12">
          <div class="card-content">
            <div class="media">
              <div class="header-content beerconsumptions">
                <div class="media-left">
                  <h4 class="card-title mt-0">Pedidos</h4>
                  <p class="card-category">Gerenciamento dos pedidos</p>
                </div>

                <div>
                  <button class="button is-success" @click="newOrder()">Novo Pedido</button>
                </div>
              </div>
            </div>
            <div class="card-body">
            </div>
            
            <div>
               <table class="table is-bordered is-striped">
                <thead>
                  <tr>
                    <th v-for="header in headers" v-bind:key="header">{{ header }}</th>
                    <th>Ações</th>
                  </tr>
                </thead>
                <tbody v-for="order in orders" v-bind:key="order.id">
                  <tr>
                    <td>
                      {{ order.order_number }}
                    </td>
                    <td>{{ order.status }}</td>
                    <td>R$ {{ order.total_price }}</td>
                    <td>{{ order.user.name || order.user.document || order.user.code }}</td>
                    <td>{{ order.payments.map((pay) => pay.name).join(',')}}</td>
                    <td>{{ order.created_at }}</td>
                    <td>  
                      <button class="button is-info" @click="editOrder(order.id)">
                        <i class="fas fa-edit"></i>
                      </button>
                      <button class="button is-danger" @click="excludeOrder(order.id)">
                        <i class="fas fa-trash-alt"></i>
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Table from '../../components/Commons/Table/Table'

export default {
  name: 'OrdersList',
  components: { Table },

  data() {
    return {
      headers: ['#', 'Status', 'Preço Total', 'Cliente', 'Meio de pagamento', 'Data'],
      orders: []
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
    this.orders = this.data[0]
  }
}
</script>

<style>

</style>