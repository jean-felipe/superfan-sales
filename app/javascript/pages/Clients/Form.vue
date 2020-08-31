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
                        <input class="input is-marginless" type="text" placeholder="080.089.098-98" 
                          v-model="client.document" required>
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
                            <input class="input is-marginless" type="date" placeholder="Nome do negócio" 
                          v-model="client.birthdate" required>
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
                            <select name="product_type" v-model="client.genre">
                              <option>Masculino</option>
                              <option>Feminino</option>
                              <option>Outro</option>
                            </select>
                          </div>
                        </div>
                    </div>

                   <div class="field">
                    <label class="label">Email</label>
                    <div class="control is-expanded">
                      <div class="is-fullwidth">
                        <input class="input is-marginless" type="email" placeholder="email@gmail.com" 
                          v-model="client.email" required>
                      </div>
                    </div>
                  </div>
                  </div>
                </div>

                <hr />
              
                <div class="field is-grouped">
                  <div class="control" v-if="edition">
                    <button type="submit" class="button is-link">Editar cliente</button>
                  </div>
                  <div class="control" v-else>
                    <button type="submit" class="button is-link">Criar cliente</button>
                  </div>
                  <div class="control">
                    <button class="button is-link is-light">Cancelar</button>
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

export default {
  name: "ClientForm",

  data() {
    return {
      edition: false,
      client: {
        name: '',
        document: '',
        genre: '',
        birthdate: '',
        email: ''
      }
    }
  },

  watch: {
    emailSearch: function(val, oldVal) {
      if(val.length > 2) {
        this.getClientsByEmail(val)
      }
    },

    documentSearch: function(val, oldVal) {
      if(val.length > 2) {
        this.getClientsByEmail(val)
      }
    }
  },

  methods: {
    sendData() {
      if(edition) {
        
      } else {
        axios.post('/api/v1/users', this.client)
          .then(response => {
            console.log(response)
          })
      }
    }
  }
}
</script>