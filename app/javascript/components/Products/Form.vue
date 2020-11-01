<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-md-12">
           <div class="card-content">
            <div class="media">
              <div class="header-content beerconsumptions">
                <div class="media-left">
                  <h4 class="card-title mt-0">Criação de Produto</h4>
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
                      <input class="input is-marginless" type="text" placeholder="Nome do negócio" 
                        v-model="newProduct.name" required>
                    </div>
                  </div>

                   <div class="field">
                    <label class="label">Descrição</label>
                    <div class="control is-expanded">
                      <div class="is-fullwidth">
                        <input class="input is-marginless" type="text" placeholder="Nome do negócio" 
                          v-model="newProduct.description" required>
                      </div>
                    </div>
                  </div>
                  </div>
                </div>

               <div class="field is-horizontal">
                  <div class="field-body">
                    <div class="field">
                      <label class="label">Categoria*</label>
                        <div class="control is-expanded">
                          <div class="select is-fullwidth">
                            <select name="product_type" v-model="newProduct.category_id">
                              <option v-for="category in categories"                      
                                v-bind:key="category.id" 
                                v-bind:value="category.id">
                                  {{ category .name }}
                              </option>
                              
                            </select>
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
                      <label class="label">EAN/SKU/Código de barras</label>
                        <div class="control is-expanded">
                          <div class="is-fullwidth">
                        <input class="input is-marginless" type="number" placeholder="2223333" 
                          v-model="newProduct.ean" required>
                      </div>
                        </div>
                    </div>

                   <div class="field">
                    <label class="label">Preço</label>
                    <div class="control is-expanded">
                      <div class="is-fullwidth">
                        <input class="input is-marginless" type="number" placeholder="3.99" 
                          v-model="newProduct.price" required>
                      </div>
                    </div>
                  </div>
                  </div>
                </div>

                <div class="field is-horizontal">
                  <div class="field">
                    <label class="label">Quantidade em estoque (unidades)</label>
                    <div class="control is-expanded">
                      <div class="is-fullwidth">
                        <input class="input is-marginless" type="number" placeholder="20" 
                          v-model="newProduct.quantity">
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
import axios from 'axios'

export default {
  name: 'ProductForm',

  data() {
    return {
      newProduct: {
        id: '',
        name: '',
        description: '',
        category_id: '',
        ean: '',
        price: '',
        has_discount: false,
        quantity: '',
      },
      categories: [],
      subcategories: [],
      edition: false,
      images: [],
      imagesPreview: ['']
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
      if (this.edition) {
        axios.patch('/api/v1/products/' + this.newProduct.id, this.newProduct)
          .then((response) => {
            this.$swal("Parabéns!", "Produto editado com sucesso!", "success")
              .then(() => {
                window.location = '/products'
              })
          })
      } else {
        axios.post('/api/v1/products', this.newProduct)
        .then((response) => {
          console.log(response)
          // // this.sendImages(response.data.id)

          this.$swal("Parabéns!", "Produto criado com sucesso!", "success")
            .then(() => {
              window.location = '/products'
            })
        })
      }
     
    },

    sendImages(id) {
      let formData = new FormData();
      this.images.forEach(file => {
        formData.append('file', this.file);
      })
      
      axios.post( '/api/v1/products/' + id + '/upload_images',
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
    if (this.data[0].product) {
      this.newProduct = this.data[0].product
      this.edition = true
    }

    this.categories = this.data[0].categories
    this.subcategories = this.data[0].sub_categories
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
</style>