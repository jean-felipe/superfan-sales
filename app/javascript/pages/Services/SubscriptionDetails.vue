<template>
  <div>
    <Panel
      title="Detalhes da Assinatura"
      title_description="Insira os dados do serviço"
      :has_action_button="false"
      :has_input_search="false">

       Detalhes do Cliente
      <table class="table is-bordered is-striped">
        <thead>
          <tr>
            <th>Nome</th>
            <th>Documento</th>
            <th>Aniversario</th>
          </tr>
        </thead>
        <tbody>
          <tr><td>{{ user.name }}</td>
          <td>{{ user.document }}</td>
          <td>{{ user.birthdate }}</td></tr>
        </tbody>
      </table>

      <hr />
      Detalhes da Assinatura
      <table class="table is-bordered is-striped">
        <thead>
          <tr>
            <th>Inicio</th>
            <th>Fim</th>
            <th>Data de pagamento</th>
            <th>Status</th>
            <th>Mensalidade</th>
            <th v-if="service.service_type == 'class'">Total de Aulas</th>
            <th v-if="service.service_type == 'class'">Aulas</th>
          </tr>
        </thead>
        <tbody>
          <tr><td>{{ subscription.start_at }}</td>
          <td>{{ subscription.end_at }}</td>
          <td>{{ subscription.pay_at }}</td>
          <td>{{ subscription.status }}</td>
          <td>R$ {{ subscription.additional_details?.custom_price }}</td>
          <td v-if="service.service_type == 'class'">{{ subscription.additional_details.total_classes }}</td>
          <td v-if="service.service_type == 'class'">{{ subscription.additional_details.total_use }}</td></tr>
        </tbody>
      </table>

      <hr />
      Ações
      <hr />
      <div class="field is-horizontal" v-if="service.service_type == 'class'">
        <div class="field-body">
          <div class="field" >
            <label class="label">Aulas</label>
            <div class="control is-expanded">
              <input class="input is-marginless" type="number"
              v-model="total_use"  required>
            </div>
          </div>
          <div class="field">

          </div>
        </div>
      </div>

      <div class="field is-grouped">
        <div class="control">
          <button type="submit" class="button is-link" @click="saveSubscription()">Salvar</button>
        </div>
        <div class="control">
          <button type="submit" class="button is-danger">Notificar pagamento</button>
        </div>
        <div class="control">
          <button class="button is-link is-light" @click="backToSubscriptions()">Voltar</button>
        </div>
      </div>
    </Panel>
  </div>
</template>
<script>
import Panel from "../../components/Commons/Panel/Panel.vue";

import axios from 'axios'
import Swal from 'sweetalert2';

export default {
  name: 'SubscriptionDetails',

  components: {Panel},

  data() {
    return {
      user: {
        name: '',
        document: '',
        birthdate: ''
      },
      service: {
        name: '',
        description: '',
        price: 0
      },
      subscription: {
        start_at: '',
        end_at: '',
        payment_day: '',
        status: ''
      },
      total_use: 0
    }
  },

  props: {
    data: {
      type: Object
    }
  },

  mounted() {
    this.user = this.data.client;
    this.service = this.data.service;
    this.subscription = this.data.subscription;
    console.log(this.subscription.additional_details.custom_price)
    if(this.data.service.service_type === 'class') {
      this.total_use = this.data.subscription.additional_details.total_use
    }
  },

  methods: {
    backToSubscriptions() {
      history.back();
    },

    saveSubscription() {
      axios.patch('/api/v1/subscriptions/' + this.subscription.id, { subscription: {total_use: this.total_use}})
        .then((response) => {
          Swal.fire("Parabéns!", "Assinatura editada com sucesso!", "success")
            .then(() => {
              location.reload()
            })
        })
    }
  }
}
</script>
<style>

</style>
