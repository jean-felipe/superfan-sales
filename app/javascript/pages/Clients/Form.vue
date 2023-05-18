<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-md-12">
           <div class="card-content">
            <div class="media">
              <div class="header-content beerconsumptions">
                <div class="media-left">
                  <h4 class="card-title mt-0">Formulário de clientes</h4>
                </div>

                <div>

                </div>
              </div>
            </div>
            <div class="card-body">
              <hr />

              <form @submit.prevent="handleSubmit">
                <div class="field is-horizontal">
                  <div class="field-body">
                     <div class="field">
                    <label class="label">Nome*</label>
                    <div class="control is-expanded">
                      <input class="input is-marginless" type="text" placeholder="Marcelo Diniz"
                        v-model="client.name" required>
                    </div>
                  </div>

                   <div class="field">
                    <label class="label">CPF</label>
                    <div class="control is-expanded">
                      <div class="is-fullwidth">
                        <input class="input is-marginless" v-if="edition" type="text" placeholder="080.089.098-98"
                          v-model="client.document" v-mask="'###.###.###-##'" required>
                        
                        <input class="input is-marginless" v-else type="text" placeholder="080.089.098-98"
                          v-model="documentSearch" v-mask="'###.###.###-##'" required>
                      </div>
                    </div>
                  </div>
                  </div>
                </div>

               <div class="field is-horizontal">
                  <div class="field-body">
                    <div class="field">
                      <label class="label">Data de Nascimento</label>
                        <div class="control is-expanded">
                          <div class="is-fullwidth">
                            <input class="input is-marginless" type="date" v-model="client.birthdate" required>
                      </div>
                        </div>
                    </div>

                   <div class="field">

                  </div>
                  </div>
                </div>

                 <div class="field is-horizontal">
                  <div class="field-body">
                    <div class="field">
                      <label class="label">Gênero</label>
                        <div class="control is-expanded">
                          <div class="select is-fullwidth">
                            <select name="product_type" v-model="client.gender">
                              <option v-for="gender in genders" v-bind:key="gender">{{gender}}</option>
                            </select>
                          </div>
                        </div>
                    </div>

                   <div class="field">
                    <label class="label">Email</label>
                    <div class="control is-expanded">
                      <div class="is-fullwidth">
                        <input class="input is-marginless" v-if="edition" type="email" placeholder="email@gmail.com"
                          v-model="client.email" required>
                        <input class="input is-marginless" v-else type="email" placeholder="email@gmail.com"
                          v-model="emailSearch" required>
                      </div>
                    </div>
                  </div>
                  </div>
                </div>

                <hr />

                <div class="field is-grouped">
                  <div class="control" v-if="edition">
                    <button type="submit" class="button is-link" @click="handleSubmit">Editar cliente</button>
                  </div>
                  <div class="control" v-else>
                    <button type="submit" class="button is-link">Criar cliente</button>
                  </div>
                  <div class="control">
                    <button class="button is-link is-light" @click="cancelButton">Cancelar</button>
                  </div>
                </div>
              </form>
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
import Swal from 'sweetalert2';
import {mask} from 'vue-the-mask'

export default {
  name: "ClientForm",
  directives: {mask},

  data() {
    return {
      edition: false,
      emailSearch: '',
      documentSearch: '',
      genders: [
        'masculino', 'feminino', 'outro'
      ],
      client: {
        id: '',
        name: '',
        document: '',
        gender: '',
        birthdate: '',
        email: ''
      }
    }
  },

  props: {
    data: {
      type: Array
    }
  },

  watch: {
    emailSearch: function(val, oldVal) {
      if(val.length > 2) {
        this.searchClients('email', val)
      }
    },

    documentSearch: function(val, oldVal) {
      if(val.length > 2) {
        this.searchClients('document', val)
      }
    }
  },

  methods: {
    handleSubmit() {
      if(this.edition) {
        axios.patch('/api/v1/clients/' + this.client.id, {client: this.client})
          .then(response => {
            Swal.fire("Parabéns!", "Cliente atualizado com sucesso!", "success")
            .then(() => {
              window.location = '/clients'
            })
          })
          .catch((response) => {
            console.log(response)
          })
      } else {
        this.client.email = this.emailSearch
        this.client.document = this.documentSearch
        this.client.gender = this.client.gender.toLowerCase()
        
        axios.post('/api/v1/clients', {client: this.client})
          .then(response => {
            Swal.fire("Parabéns!", "Cliente cadastrado com sucesso!", "success")
            .then(() => {
              window.location = '/clients'
            })
          })
          .catch((response) => {
            console.log(response)
          })
      }
    },

    searchClients(type, val) {
      axios.get(`/api/v1/clients?filter[${type}]=` + val)
        .then(response => {
          if (response.data.user) {
            this.client = response.data.user
            this.emailSearch = response.data.user.email
            this.documentSearch = response.data.user.document
          }
        })
    },

    cancelButton() {
      window.location = '/clients'
    }
  },

  mounted() {
    console.log(this.data[0])
    if(this.data[0].edit) {
      this.edition = true
      this.client = this.data[0].client
    }
  }
}
</script>
