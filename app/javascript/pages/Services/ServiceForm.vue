<template>
<div>
  <Panel
    title="Criação de serviço"
    title_description="Insira os dados do serviço"
    :has_action_button="false"
    :has_input_search="false">

      <form @submit.prevent="handleSubmit">
        <div class="field is-horizontal">
          <div class="field-body">
              <div class="field">
                <label class="label">Nome*</label>
                <div class="control is-expanded">
                  <input class="input is-marginless" type="text" placeholder="Nome do Serviço"
                    v-model="newService.name" required>
                </div>
              </div>
            </div>
            </div>

          <div class="field is-horizontal">
            <div class="field-body">
              <div class="field">
                <label class="label">Duracao</label>
                <div class="control is-expanded">
                    <div class="select is-fullwidth">
                      <select name="service_type" v-model="newService.definitions.duration">
                        <option v-for="unit in serviceDurationOptions"
                          v-bind:key="unit"
                          v-bind:value="unit">
                            {{ unit }}
                        </option>

                      </select>
                    </div>
                  </div>
              </div>

            <div class="field">
              <label class="label">Duracao quantidade</label>
              <div class="control is-expanded">
                <div class="is-fullwidth">
                  <input class="input is-marginless" type="number" v-model="newService.definitions.duration_quantity"
                    placeholder="3" min="0" step=".01" require>
                </div>
              </div>
            </div>
            </div>
          </div>

          <div class="field is-horizontal">
          <div class="field-body">
            <div class="field">
               <label class="label">Tipo do serviço</label>
                <div class="control is-expanded">
                    <div class="select is-fullwidth">
                      <select name="service_type" v-model="newService.service_type">
                        <option v-for="unit in serviceTypeOptions"
                          v-bind:key="unit"
                          v-bind:value="unit">
                            {{ unit }}
                        </option>

                      </select>
                    </div>
                  </div>
            </div>

            <div class="field">
            <label class="label">Preço Unitário (equivalente a um consumo desse serviço)</label>
            <div class="control is-expanded">
              <div class="is-fullwidth">
                <input class="input is-marginless" type="number" placeholder="3.99"
                  v-model="newService.price" min="0" step=".01" required>
              </div>
            </div>
          </div>
          </div>
        </div>

        <div class="field is-horizontal">
          <div class="field">
            <label class="label">Descrição</label>
            <div class="control is-expanded">
              <div class="is-fullwidth">
                <textarea
                  class="textarea is-marginless"
                  type="text"
                  placeholder="Esse produto e feito por xxx"
                  rows="5" cols="80"
                  v-model="newService.description" required></textarea>
              </div>
            </div>
          </div>
          <div class="field-body">
            <div class="field">

            </div>

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
import Panel from '../../components/Commons/Panel/Panel.vue';
import axios from 'axios'
import Swal from 'sweetalert2';

export default {
  name: 'serviceForm',
  components: { Panel },

  data() {
    return {
      newService: {
        id: '',
        name: '',
        description: '',
        price: '',
        has_discount: false,
        service_type: '',
        definitions: {
          duration: '',
          duration_quantity: '',
        },
      },
      edition: false,
      images: [],
      imagesPreview: [''],
      serviceDurationOptions: ['Hora', 'Dia', 'Semana', 'Mes'],
      serviceTypeOptions: ['Aula', 'Sob Demanda', 'Consumo']
    }
  },

  props: {
    data: {
      type: Array,
      require: true
    },
  },

  methods: {
    handleSubmit() {
      this.loadServiceType(this.newService)
      if (this.edition) {
        axios.patch('/api/v1/service_definitions/' + this.newService.id, this.newService)
          .then((response) => {
            Swal.fire("Parabéns!", "Serviço editado com sucesso!", "success")
              .then(() => {
                window.location = '/service_definitions'
              })
          })
      } else {
        axios.post('/api/v1/service_definitions', this.newService)
        .then((response) => {
          console.log(response)
          // // this.sendImages(response.data.id)

          Swal.fire("Parabéns!", "Serviço criado com sucesso!", "success")
            .then(() => {
              window.location = '/service_definitions'
            })
        })
      }

    },

    loadServiceType(newService) {
      switch(newService.service_type) {
        case 'Aula':
          newService.service_type = 'class'
          break;
        case 'Sob Demanda':
          newService.service_type = 'on_demand'
          break;
        case 'Consumo':
          newService.service_type = 'stream'
          break;
        default:
          break;
      }
    },

    sendImages(id) {
      let formData = new FormData();
      this.images.forEach(file => {
        formData.append('file', this.file);
      })

      axios.post( '/api/v1/services/' + id + '/upload_images',
      formData,
      {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      }
    ).then(function(){
      console.log('SUCCESS!!');
    })
    .catch(function(){
      console.log('FAILURE!!');
    });
    },

    previewFiles(event) {
       let files = event.target.files
       let file
       for (var i = 0; i < files.length; i++) {
         // obtém o item
          file = files.item(i);

          this.images.push(file)
          this.imagesPreview.push(URL.createObjectURL(file))
       }
    }
  },

  mounted() {
    if (this.data[0].service) {
      this.newService = this.data[0].service
      this.edition = true
    }
  }
}
</script>

<style>
.img-preview {
  height: 300px;
  width: 300px;
  margin-right: 20px;
}

.preview {
  display: flex;
}

.botao-mais-e-menos a {
  margin-top: 30px
}
</style>
