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
                    <label class="label">EAN</label>
                    <div class="control is-expanded">
                      <div class="is-fullwidth">
                        <input class="input is-marginless" type="number" placeholder="Nome do negócio" 
                          v-model="newProduct.ean" required>
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

export default {
  name: 'ProductForm',

  data() {
    return {
      newProduct: {
        name: '',
        description: '',
        category_id: '',
        ean: '',
      },
      categories: [],
      edition: false,
    }
  }
}
</script>

<style>

</style>