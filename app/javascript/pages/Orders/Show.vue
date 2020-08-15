<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-md-12">
          <div class="card-content">
            <div class="media">
              <div class="header-content beerconsumptions">
                <div class="media-left">
                  <h4 class="card-title mt-0">Pedido # {{order.order_number}}</h4>
                  <p class="card-category">
                    Cliente:
                    <table class="table is-bordered is-striped">
                      <thead>
                        <tr>
                          <th v-for="header in customerHeaders" v-bind:key="header">{{ header }}</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>{{ order.user.name }}</td>
                          <td>{{ order.user.document }}</td>
                          <td>{{ order.user.code }}</td>
                        </tr>
                      </tbody>
                    </table>
                  </p>
                </div>

                <div>
                  
                </div>
              </div>
            </div>
            <div class="card-body">
              <section class="items-details">
                <div class="items-details-header">
                  <h3>Items:</h3>
                  <button class="button is-success">Adicionar</button>
                </div>
                <table class="table is-bordered is-striped">
                  <thead>
                    <tr>
                      <th v-for="header in itemsHeaders" v-bind:key="header">{{ header }}</th>
                      <th>Ações</th>
                    </tr>
                  </thead>
                  <tbody v-for="item in order.items" v-bind:key="item.id">
                    <tr>
                      <td>{{ item.product }}</td>
                      <td>R$ {{ item.price }}</td>
                      <td>{{ item.quantity }}</td>
                      <td>
                        <button class="button is-danger">Remover</button>
                        <button class="button is-success">Alterar Preço</button>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </section>

              <section class="total-price">
                <br>
                <h3>Total: R$ {{order.total_price}},00</h3>
              </section>

              <section class="payment">
                <hr>
                <button class="button is-success">Pagar</button>
                <button class="button is-danger">Cancelar</button>
                <button class="button is-primary">Editar</button>
              </section>
             
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "ShowOrder",

  data() {
    return {
      customerHeaders: ['Nome', 'CPF', 'Código'],
      itemsHeaders: ['Nome', 'Preço', 'Quantidade'],
      order: {
        number: '',
        user: {},
        items: []
      }
    }
  },

  props: {
    data: {
      type: Array
    }
  },

  mounted() {
    console.log(this.data)
    this.order = this.data[0]
  }
}
</script>

<style scoped>
.items-details-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
}
</style>