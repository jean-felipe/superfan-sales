<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-md-12">
          <div class="card-content">
            <div class="media">
              <div class="header-content beerconsumptions">
                <div class="media-left">
                  <h4 class="card-title mt-0">Clientes</h4>
                  <p class="card-category">Gerenciamento administrativo de clientes</p>
                </div>

                <div>
                  <button class="button is-success" @click="newClient()">Novo Cadastro</button>
                </div>
              </div>
            </div>
            <div class="card-body">
            </div>

            <div>
              <table class="table is-bordered is-striped">
                <thead>
                  <tr>
                    <th v-for="header in tableHeaders" v-bind:key="header">{{ header }}</th>
                  </tr>
                </thead>
                <tbody v-for="element in clients" v-bind:key="element.id">
                  <tr @click="showCompany(element.id)">
                    <td>
                      {{ element.id }}
                    </td>
                    <td>
                      {{ element.document }}
                    </td>
                    <td>
                      {{ element.fantasy_name }}
                    </td>
                    <td>
                      {{ element.legal_name }}
                    </td>
                    <td>
                      {{ element.phone }}
                    </td>
                    <td>
                      {{ element.user.email }}
                    </td>
                    <td>
                      {{ element.created_at }}
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
import Table from '../../components/Commons/Table/Table';

export default {
  name: 'AdminClientList',
  components: {Table},

  data() {
    return {
      clients: [],
      hasDeleteAction: false,
      hasEditAction: true,
      tableHeaders: [
        "#", "CNPJ", "Nome fantasia", "Nome legal", "Fone", "Email", "Entrou em"
      ]
    }
  },
  props: {
    data: {
      type: Array
    }
  },

  methods: {
    newClient() {
      window.location = '/admin/new'
    },

    showCompany(id) {

    }
  },

  mounted() {
    this.clients = this.data[0].clients
  }
}
</script>
