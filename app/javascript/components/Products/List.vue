<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-md-12">
          <div class="card-content">
            <div class="media">
              <div class="header-content beerconsumptions">
                <div class="media-left">
                  <h4 class="card-title mt-0">Produtos</h4>
                  <p class="card-category">Gerenciamento de produtos</p>
                </div>

                <div>
                  <button class="button is-success" @click="newProduct()">Novo Produto</button>
                </div>
              </div>
            </div>
            <div class="card-body">
            </div>
            
            <div>
              <Table :headers="tableHeaders" :elements="products" url="/products"/>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Table from '../Commons/Table/Table'

export default {
  name: 'ProductsList',
  components: { Table },

  data() {
    return {
      tableHeaders: ['#', 'Nome'],
      products: []
    }
  }
}
</script>

<style>

</style>