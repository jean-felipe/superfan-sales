<template>
  <div>
    <Panel
      :title="product_name"
      title_description="Gerencie suas assinaturas"
      :has_action_button="true"
      button_action_label="Nova Assinatura"
      :action_path="service_id + '/subscriptions/new'"
      :has_input_search="true">

        <div>
          <Table
            :headers="tableHeaders"
            :elements="loadProducts"
            :hasEditAction="true"
            :hasDeleteAction="false"
            :url="`/service_definitions/${service_id}/subscriptions`"/>
          <Pagination :pages="pages" :currentPage="loadCurrentPage" @changePage="handleChangePage" />
        </div>

    </Panel>
  </div>
</template>
<script>
import Panel from "../../components/Commons/Panel/Panel.vue";
import Table from "../../components//Commons/Table/Table.vue";

export default {
  name: 'SubscriptionsList',

  components: { Panel, Table },

  data() {
    return {
      subscriptions: [],
      tableHeaders: ['#', 'Nome', 'Data Inicio', 'Data Fim', 'Status'],
      pages: 1,
      currentPage: 1,
      page: 1,
      product_name: '',
      product_id: '',
      service_id: '',
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
      return this.subscriptions
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
    this.subscriptions = this.data[0].subscriptions
    this.product_name = this.data[0].product_name
    this.product_id = this.data[0].product_id
    this.service_id = this.data[0].service_id
  }
}
</script>
<style>

</style>
