<template>
  <div>
    <Panel
      title="Produtos"
      title_description="Gerencie seus produtos"
      :has_action_button="true"
      button_action_label="Novo Produto"
      action_path="/products/new"
      has_second_action_button="true"
      second_action_path="products/import"
      second_button_action_label="Importar"
      :has_input_search="true">
        <div>
          <Table :headers="tableHeaders" :elements="loadProducts" url="/products"/>
          <Pagination :pages="pages" :currentPage="loadCurrentPage" @changePage="handleChangePage" />
        </div>
    </Panel>

    <ImportationModal v-if="showModal" @close="showModal = false"/>
  </div>
</template>

<script>
import Table from '../Commons/Table/Table.vue';
import Pagination from '../Commons/Table/Pagination.vue';
import ImportationModal from './ImportationModal.vue';
import Panel from "../Commons/Panel/Panel.vue";

import axios from 'axios';

export default {
  name: 'ProductsList',
  components: { Table, ImportationModal, Pagination, Panel },

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
