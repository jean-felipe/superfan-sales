<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-md-12">
           <div class="card-content">
            <div class="media">
              <div class="header-content beerconsumptions">
                <div class="media-left">
                  <h4 class="card-title mt-0">Seu estabelecimento</h4>
                </div>

                <div>
                  
                </div>
              </div>
            </div>
            <div class="card-body">
              <hr />
                <table class="table is-bordered is-striped">
                  <thead>
                    <tr>
                      <th>Data de Criação</th>
                      <th>Nome Fantasia</th>
                      <th>Nome Comercial</th>
                      <th>Telefone</th>
                      <th>Segmento</th>
                      <th>Descrição</th>
                      <th>Ações</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>{{ company.created_at }}</td>
                      <td>{{ company.fantasy_name }}</td>
                      <td>{{ company.legal_name }}</td>
                      <td>{{ company.phone }}</td>
                      <td>{{ company.segment }}</td>
                      <td>{{ company.description }}</td>
                      <td>
                        <button class="button is-info" @click="editElement(company.id)">
                          <i class="fas fa-edit"></i>
                        </button>
                      </td>

                    </tr>
                  </tbody>
                </table>

                <hr />

                Relatórios
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
export default {
  name: 'Show',

  data() {
    return {
      company: {}
    }
  },

  props: {
    data: {
      type: Array
    }
  },

  methods: {
    editElement(id) {
      window.location =  '/companies/' + id + '/edit'
    },
  },

  mounted() {
    this.company = this.data[0]
  }
}
</script>