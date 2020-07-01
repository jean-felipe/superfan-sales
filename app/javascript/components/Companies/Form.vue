<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-md-12">
           <div class="card-content">
            <div class="media">
              <div class="header-content beerconsumptions">
                <div class="media-left">
                  <h4 class="card-title mt-0">Insira os dados do seu estabelecimento</h4>
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
                            <select name="product_type" v-model="company.category_id">
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
                           <input class="input is-marginless" type="number" placeholder="Nome do negócio" 
                             v-model="company.phone" required>
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

export default {
  name: 'Form',

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
      axios.post('/api/v1/companies', this.company)
        .then((response) => {
          console.log(response)
        })
    }
  },

  props: {
    data: {
      type: Array,
    }
  },

  mounted() {
    this.segments = this.data[0].segments
  }

}
</script>