<template>
  <div>
    <Panel
      title="Configuração de serviço"
      title_description="Gerencie os serviços"
      :has_action_button="false"
      button_action_label="Novo Serviço"
      action_path="subscriptions/new"
      :has_input_search="false">

        <form @submit.prevent="handleSubmit">
          <div class="field is-horizontal">
            <div class="field-body">
              <div class="field">
                <label class="label">Cliente (CPF)*</label>
                <div class="control is-expanded">
                  <input class="input is-marginless" type="text" placeholder="080.089.098-98"
                          v-model="searchCustomer" v-mask="'###.###.###-##'" required>
                </div>
              </div>
            </div>
            </div>
             <div class="products-list" v-if="customersList" >
                <table class="table is-bordered is-striped">
                  <tr>
                    <th>Nome</th>
                    <th>Email</th>
                    <td>Documento</td>
                  </tr>

                  <tbody v-for="customer in customers" v-bind:key="customer.id">
                    <tr>
                      <td>{{ customer.name }}</td>
                      <td>{{ customer.email }}</td>
                      <td>{{ customer.document }}</td>
                      <td>
                        <button class="button is-success has-magin-bottom" @click="addCustomer(customer)">Adicionar</button>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

          <div class="field">
            <div class="field">
              <label class="label">Data de Inicio</label>
              <div class="control is-expanded">
                <div class="is-fullwidth">
                  <input class="input is-marginless" type="date" v-model="newSubscription.start_at" required>
                </div>
              </div>
            </div>
          </div>

          <div class="field">
            <div class="field">
              <label class="label">Data de Fim</label>
                <div class="control is-expanded">
                  <div class="is-fullwidth">
                    <input class="input is-marginless" type="date" v-model="newSubscription.end_at" required>
                </div>
              </div>
            </div>
          </div>

          <div class="field">
            <div class="field">
              <label class="label">Data de Pagamento</label>
                <div class="control is-expanded">
                  <div class="is-fullwidth">
                    <input class="input is-marginless" type="date" v-model="newSubscription.pay_at" required>
                </div>
              </div>
            </div>
          </div>

          <hr />

          <div class="field">
            <div class="field">
                <label class="checkbox">
                  <input type="checkbox" v-model="newSubscription.start_payment">
                  Inicio pago
                </label>
            </div>
            <div class="field">
                <label class="checkbox">
                  <input type="checkbox" v-model="additional_details">
                  Detalhes adicionais
                </label>
            </div>
          </div>

          <div class="field" v-if="newSubscription.start_payment">
            <div class="field">
              <label class="label">Data do primeiro pagamento</label>
                <div class="control is-expanded">
                  <div class="is-fullwidth">
                    <input class="input is-marginless" type="date"
                       v-model="newSubscription.additional_details.start_payment_date">
                </div>
              </div>
            </div>
          </div>

          <div class="field" v-if="additional_details">
            <label class="label">Total de uso</label>
            <div class="control is-expanded">
              <input class="input is-marginless" type="number" v-model="newSubscription.additional_details.total_use"  required>
            </div>
          </div>

      <hr />

      <div class="field is-grouped">
        <div class="control" v-if="edition">
          <button type="submit" class="button is-link">Editar Produto</button>
        </div>
        <div class="control" v-else>
          <button type="submit" class="button is-link">Criar Produto</button>
        </div>
        <div class="control">
          <button class="button is-link is-light">Cancelar</button>
        </div>
      </div>
    </form>
  </Panel>
 </div>
</template>

<script>
import Panel from "../../components/Commons/Panel/Panel.vue";
import axios from 'axios'
import Swal from 'sweetalert2';

import {mask} from 'vue-the-mask'

export default {
  name: 'SubscriptionForm',
  components: { Panel },
  directives: {mask},

  data() {
    return {
      newSubscription: {
        id: '',
        client_id: '',
        start_at: '',
        end_at: '',
        product_id: '',
        pay_at: '',
        start_payment: false,
        additional_details: {
          start_payment_date: '',
          total_use: 0,
        },
      },
      additional_details: false,
      searchCustomer: '',
      customers: [],
      customersList: false,
      edition: false,
      serviceDurationOptions: ['Hora', 'Dia', 'Semana', 'Mes'],
    }
  },

  props: {
    data: {
      type: Array,
      require: true
    },
  },

  watch: {
    searchCustomer: function(val, oldVal) {
      if(val.length > 2) {
        this.getCustomers(val)
      }
    },
  },

  methods: {
    handleSubmit() {
      if (this.edition) {
        axios.patch('/api/v1/subscriptions/' + this.newSubscription.id, this.newSubscription)
          .then((response) => {
            Swal.fire("Parabéns!", "Assinatura editada com sucesso!", "success")
              .then(() => {
                window.location = '/subscriptions'
              })
          })
      } else {
        axios.post('/api/v1/subscriptions', {subscription: this.newSubscription})
        .then((response) => {
          console.log(response)
          // // this.sendImages(response.data.id)

          Swal.fire("Parabéns!", "Assinatura criada com sucesso!", "success")
            .then(() => {
              window.location = '/subscriptions'
            })
        })
      }
    },

    getCustomers(word) {
      axios.get('/api/v1/clients?filter[document]=' + word )
        .then(response => {
          this.customers = response.data
          this.customersList = true
        })
    },

    addCustomer(customer) {
      console.log('customer', customer)
      this.newSubscription.client_id = customer.id
      this.searchCustomer = customer.document
    }
  },

  mounted() {
    if (this.edition) {
      if (this.data[0].subscription) {
        this.newSubscription = this.data[0].subscription
        this.edition = true
      }
    }

    console.log(this.data[0])

    this.newSubscription.product_id = this.data.product.id
  }
}
</script>

<style>

</style>
