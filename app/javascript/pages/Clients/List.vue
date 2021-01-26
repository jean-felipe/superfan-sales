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
                  <p class="card-category">Gerenciamento de produtos</p>
                </div>

                <div>
                  <button class="button is-success" @click="newClient()">Novo Cadastro</button>
                </div>
              </div>
            </div>
            <div class="card-body">
            </div>
            
            <div>
              <Table :headers="tableHeaders" :elements="clients" url="/clients" :hasDeleteAction="hasDeleteAction" :hasEditAction="hasEditAction"/>
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
  name: 'ClientsList',
  components: {Table},

  data() {
    return {
      clients: [],
      hasDeleteAction: false,
      hasEditAction: true,
      tableHeaders: [
        "#", "Código", "Nome", "E-mail", "Documento", "Genero"
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
      window.location = '/clients/new'
    }
  },

  mounted() {
    this.clients = this.data[0].clients
  }
}
</script>