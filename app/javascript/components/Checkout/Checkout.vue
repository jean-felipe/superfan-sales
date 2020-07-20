<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-md-12">
           <div class="card-content">
            <div class="media">
              <div class="header-content beerconsumptions">
                <div class="media-left">
                  <h4 class="card-title mt-0">Caixa</h4>
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
                         required>
                    </div>
                  </div>

                   <div class="field">
                    <label class="label">Descrição</label>
                    <div class="control is-expanded">
                      <div class="is-fullwidth">
                        <input class="input is-marginless" type="text" placeholder="Nome do negócio" 
                           required>
                      </div>
                    </div>
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
export default {
  name: 'Checkout',

  data() {
    return {
      
    }
  }
}
</script>