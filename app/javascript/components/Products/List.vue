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
                  <button class="button is-success" @click="showModal = true">
                    <span>Importação</span>
                    <span class="icon"><i class="fas fa-download"></i></span>
                  </button>
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

    <ImportationModal v-if="showModal" @close="showModal = false"/>
  </div>
</template>

<script>
import Table from '../Commons/Table/Table';
import ImportationModal from './ImportationModal';

export default {
  name: 'ProductsList',
  components: { Table, ImportationModal },

  data() {
    return {
      tableHeaders: ['#', 'Nome', 'Descrição', 'Preço', 'Estoque'],
      products: [],
      showModal: false,
    }
  },

  props: {
    data: {
      type: Array
    }
  },

  methods: {
    newProduct() {
      window.location.href = '/products/new';
    }
  },

  mounted() {
    console.log(this.data)
    this.products = this.data[0]
  }
}
</script>

<style>

</style>