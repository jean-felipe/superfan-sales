<template>
  <div>
    <Panel
      title="Configuração de serviço"
      title_description="Gerencie os serviços"
      :has_action_button="true"
      button_action_label="Novo Serviço"
      action_path="/service_definitions/new"
      :has_input_search="false">

        <div>
          <Table :headers="tableHeaders" :elements="loadProducts" url="/service_definitions"/>
          <Pagination :pages="pages" :currentPage="loadCurrentPage" @changePage="handleChangePage" />
        </div>

    </Panel>
  </div>
</template>
<script>
import Panel from "../../components/Commons/Panel/Panel.vue";
import Table from "../../components//Commons/Table/Table.vue";

export default {
  name: 'ServicesList',

  components: { Panel, Table },

  data() {
    return {
      services: [],
      tableHeaders: ['#', 'Nome', 'Descrição', 'Preço'],
      pages: 1,
      currentPage: 1,
      page: 1,
      // productConfigs: {
      //   registrationRequired: false,
      //   registrationPrice: 0,
      //   subscription: false,
      //   subscriptionPrice: 0,na
      //   subscriptionPaymentDay: 1,
      //   notifyPaymentDay: false,

      // }
    }
  },

  computed: {
    loadProducts() {
      return this.services
    },

    loadCurrentPage() {
      return this.currentPage
    },
  },

  methods: {
    handleChangePage(page) {
      this.currentPage = page
      window.location.href = `/products?page=${page}`
    },
  },

  props: {
    data: {
      type: Array
    }
  },

  mounted() {
    this.services = this.data[0].services
  }
}
</script>
<style>

</style>
