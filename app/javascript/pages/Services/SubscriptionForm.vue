<template>
  <div>
    <Panel
      title="Criar Assinatura"
      title_description="Insira os dados da nova assinatura"
      :has_action_button="false"
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

          <div class="field is-horizontal">
            <div class="field-body">
              <div class="field">
                  <label class="label">Data de Inicio</label>
                  <div class="control is-expanded">
                    <div class="is-fullwidth">
                      <input class="input is-marginless" type="date" v-model="newSubscription.start_at" required>
                    </div>
                  </div>
                </div>

              <div class="field">
                <label class="label">Data de Fim</label>
                  <div class="control is-expanded">
                    <div class="is-fullwidth">
                      <input class="input is-marginless" type="date" v-model="newSubscription.end_at" required>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="field is-horizontal">
            <div class="field-body">
              <div class="field">
                <label class="label">Data de Pagamento</label>
                  <div class="control is-expanded">
                    <div class="is-fullwidth">
                      <input class="input is-marginless" type="date" v-model="newSubscription.pay_at" required>
                  </div>
                </div>
              </div>

              <div class="field"></div>
            </div>
          </div>

          <hr />


          <div class="field is-horizontal" v-if="service.service_type == 'class'">
            <hr>
            <div class="field-body">
              <div class="field" >
                <label class="label">Total de Aulas</label>
                <div class="control is-expanded">
                  <input class="input is-marginless" type="number"
                  v-model="newSubscription.additional_details.total_classes"  required>
                </div>
              </div>
              <div class="field">
                <label class="label">Frequencia semanal</label>
                <div class="control is-expanded">
                  <input class="input is-marginless" type="number"
                  v-model="newSubscription.additional_details.weekly_attendance"  required>
                </div>
              </div>
            </div>
          </div>

          <div class="field is-horizontal" v-if="service.service_type == 'class'">
            <hr>
            <div class="field-body">
              <div class="field" >
                <label class="label">Preço Final</label>
                <div class="control is-expanded">
                  <input class="input is-marginless" type="number"
                  v-model="newSubscription.additional_details.custom_price"  required>
                </div>
              </div>
              <div class="field">

              </div>
            </div>
          </div>

      <hr />
       <p>Valor estimado: <label>R$ {{ newSubscription.additional_details.total_classes * service.price }}</label></p>
       <p>Desconto: <label>R$ {{ (newSubscription.additional_details.total_classes * service.price) - newSubscription.additional_details.custom_price}}</label></p>
      <div class="field is-grouped">
        <div class="control" v-if="edition">
          <button type="submit" class="button is-link">Editar Assinatura</button>
        </div>
        <div class="control" v-else>
          <button type="submit" class="button is-link">Criar Assinatura</button>
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
        service_definition_id: '',
        pay_at: '',
        start_payment: false,
        additional_details: {
          start_payment_date: '',
          total_use: 0,
          total_classes: 0,
          weekly_attendance: 0,
          total_price: 0.0,
          custom_price: 0.0
        },
      },
      additional_details: false,
      searchCustomer: '',
      total_price: 0.0,
      customers: [],
      customersList: false,
      edition: false,
      service: {},
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
                window.location = `/service_definitions/${this.newSubscription.service_definition_id}`
              })
          })
      } else {
        axios.post('/api/v1/subscriptions', {subscription: this.newSubscription})
        .then((response) => {
          console.log(response)
          // // this.sendImages(response.data.id)

          Swal.fire("Parabéns!", "Assinatura criada com sucesso!", "success")
            .then(() => {
              window.location = `/service_definitions/${this.newSubscription.service_definition_id}`
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

    this.newSubscription.service_definition_id = this.data.service.id
    this.service = this.data.service
  },

  computed: {
    total_price() {
      return this.newSubscription.additional_details.total_classes * this.service.price
    }
  }
}
</script>

<style>

</style>
