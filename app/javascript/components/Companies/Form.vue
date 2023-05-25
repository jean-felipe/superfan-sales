<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-md-12">
           <div class="card-content">
            <div class="media">
              <div class="header-content beerconsumptions">
                <div class="media-left">
                  <h4 class="card-title mt-0" v-if="edition">Seu estabelecimento</h4>
                  <h4 class="card-title mt-0" v-else>Insira os dados do seu estabelecimento</h4>
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
                      <label class="label">Nome Comercial*</label>
                      <div class="control is-expanded">
                        <input class="input is-marginless" type="text" placeholder="Nome do negócio" 
                          v-model="company.legal_name" required>
                       </div>
                    </div>

                    <div class="field">
                      <label class="label">Nome Fantasia*</label>
                      <div class="control is-expanded">
                        <input class="input is-marginless" type="text" placeholder="Nome do negócio" 
                          v-model="company.fantasy_name" required>
                       </div>
                    </div>

                  </div>
                </div>

               <div class="field is-horizontal">
                  <div class="field-body">
                    <div class="field">
                      <label class="label">Segmento*</label>
                        <div class="control is-expanded">
                          <div class="select is-fullwidth">
                            <select name="product_type" v-model="company.segment_id">
                              <option v-for="category in segments"                      
                                v-bind:key="category.id" 
                                v-bind:value="category.id">
                                  {{ category .name }}
                              </option>
                              
                            </select>
                          </div>
                        </div>
                    </div>

                   <div class="field">
                    <label class="label">CNPJ</label>
                    <div class="control is-expanded">
                      <div class="is-fullwidth">
                        <input class="input is-marginless" type="number" placeholder="Nome do negócio" 
                          v-model="company.document" required>
                      </div>
                    </div>
                  </div>
                  </div>
                </div>

                <div class="field is-horizontal">
                  <div class="field-body">
                    <div class="field">
                      <label class="label">Telefone*</label>
                        <div class="control is-expanded">
                           <input class="input is-marginless" type="text" placeholder="Nome do negócio"
                             v-model="company.phone" v-mask="'(##) # ####-####'" required>
                        </div>
                    </div>

                     <div class="field">
                    <label class="label">Descrição</label>
                    <div class="control is-expanded">
                      <div class="is-fullwidth">
                        <input class="input is-marginless" type="text" placeholder="Nome do negócio" 
                          v-model="company.description" required>
                      </div>
                    </div>
                  </div>

                  </div>
                </div>

                

                <hr />
                <div class="field is-horizontal">
                  <div class="field-body">
                    <div class="field">
                      <label class="label">Imagens*</label>
                      <div class="control is-expanded"></div>
                    </div>
                  </div>
                </div>

                <div class="field is-grouped">
                  <div class="control" v-if="edition">
                    <button type="submit" class="button is-link">Editar Estabelecimento</button>
                  </div>
                  <div class="control" v-else>
                    <button type="submit" class="button is-link">Criar Estabelecimento</button>
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
import Swal from 'sweetalert2';
import {mask} from 'vue-the-mask'

export default {
  name: 'Form',
  directives: {mask},

  data() {
    return {
      company: {
        document: '',
        description: '',
        segment_id: '',
        description: '',
        fantasy_name: '',
        legal_name: '',
        phone: '',
      },
      edition: false,
      segments: []
    }
  },

  methods: {
    handleSubmit() {
      if(this.edition) {
        axios.patch('/api/v1/companies/' + this.company.id, this.company)
          .then(() => {
            Swal.fire("Parabéns!", "Estabelecimento atualizado com sucesso", "success")
              .then(() => {
                window.location = '/companies/' + this.company.id
              })
          })
          .catch(() => {
            Swal.fire("Ops!", "Houve um erro, confira os dados e tente novamente", "error")
          })
      } else {
        axios.post('/api/v1/companies', this.company)
          .then((response) => {
            Swal.fire("Parabéns!", "Loja Cadastrada com sucesso", "success")
              .then(() => {
                window.location = '/products'
              })
          .catch(() => {
            Swal.fire("Ops!", "Houve um erro, confira os dados e tente novamente", "error")
          })
       })
      }

    }
  },

  props: {
    data: {
      type: Array,
    }
  },

  mounted() {
    this.segments = this.data[0].segments
    if(this.data[0].company) {
      this.company = this.data[0].company
      this.edition = true
    }
  }

}
</script>
