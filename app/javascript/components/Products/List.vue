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
                <div class="search">

                  <div class="field">
                    <p class="control has-icons-left has-icons-right">
                      <input type="search" class="input is-marginless" placeholder="Pesquisa" v-model="searchTerm"/>
                      <span class="icon is-small is-left">
                        <i class="fas fa-search"></i>
                      </span>
                    </p>
                  </div>

                </div>
              </div>
            </div>
            <div class="card-body">
            </div>

            <div>
              <Table :headers="tableHeaders" :elements="loadProducts" url="/products"/>
              <Pagination :pages="pages" :currentPage="loadCurrentPage" @changePage="handleChangePage" />
            </div>
          </div>
        </div>
      </div>
    </div>

    <ImportationModal v-if="showModal" @close="showModal = false"/>
  </div>
</template>

<script>
import Table from '../Commons/Table/Table.vue';
import Pagination from '../Commons/Table/Pagination.vue';
import ImportationModal from './ImportationModal.vue';
import axios from 'axios';

export default {
  name: 'ProductsList',
  components: { Table, ImportationModal, Pagination },

  data() {
    return {
      tableHeaders: ['#', 'Nome', 'Descrição', 'Preço', 'Estoque'],
      products: [],
      showModal: false,
      pages: 1,
      currentPage: 1,
      page: 1,
      searchTerm: ''
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
    },

    handleChangePage(page) {
      this.currentPage = page
      window.location.href = `/products?page=${page}`
    },

    getProducts(word) {
      axios.get('/api/v1/products?filter=' + word + '&fields=id,name,description,price,quantity')
        .then(response => {
          this.products = response.data
        })
    },
  },

  computed: {
    loadCurrentPage() {
      return this.currentPage
    },

    loadProducts() {
      return this.products
    }
  },

  watch: {
    searchTerm: function(val, oldVal) {
      if(val.length > 2) {
        this.getProducts(val)
      }
    },
  },

  mounted() {
    console.log(this.data)
    this.products = this.data[0].products
    this.pages = this.data[0].pages
    this.currentPage = this.data[0].current_page
  }
}
</script>

<style>

</style>
