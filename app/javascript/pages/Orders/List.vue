<template>
  <div>
    <Panel title="Pedidos" title_description="Gerencie seus pedidos" :has_action_button="true"
      button_action_label="Novo Pedido" action_path="/orders/new" :has_input_search="true">

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
              <td>{{ order.delivery_type }}</td>
              <td>{{ order.created_at }}</td>
              <td>
                <button class="button is-info mr-1" @click="editOrder(order.id)">
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
    </Panel>
  </div>
</template>

<script>
import Panel from '../../components/Commons/Panel/Panel.vue'

export default {
  name: 'OrdersList',
  components: { Panel },

  data() {
    return {
      headers: ['#', 'Status', 'Preço Total', 'Cliente', 'Meio de pagamento', 'Tipo de entrega', 'Data'],
      orders: []
    }
  },

  props: {
    data: {
      type: Array
    }
  },

  computed: {
    loadOrders() {
      return this.orders
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
