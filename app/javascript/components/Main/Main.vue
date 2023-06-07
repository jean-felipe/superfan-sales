<template>
  <div>
    <div class="wrapper" v-if="componentName != 'home'">
      <div class="dashboard">
        <Sidebar :user="user" />
        <div class="main-panel">
          <Header :user="user" />
          <div class="content">
            <component :is="loadComponent" :data="componentData" />
          </div>
        </div>
      </div>
    </div>

    <div class="home" v-else>
      <component :is="loadComponent" :data="componentData" />
    </div>
  </div>
</template>

<script>
import "bulma/css/bulma.css";
// import 'bulma-o-steps/bulma-steps.css';

import Sidebar from "../Commons/Sidebar/Sidebar.vue";
import Header from "../Commons/Header/Header.vue";

import ProductsList from "../Products/List.vue";
import ProductForm from "../Products/Form.vue";

import CompanyForm from "../Companies/Form.vue";
import ShowCompany from "../Companies/Show.vue";

import Checkout from "../Checkout/Checkout.vue";

import Saloon from "../../pages/Saloon/Saloon.vue";
import TableForm from "../../pages/Saloon/Management/TableForm.vue";

import OrdersList from "../../pages/Orders/List.vue";
import ShowOrder from "../../pages/Orders/Show.vue";
import OrderForm from "../../pages/Orders/Form.vue";

import ClientsList from "../../pages/Clients/List.vue";
import ClientForm from "../../pages/Clients/Form.vue";

import DailyReport from "../../pages/Reports/DailyReport.vue";

import AdminClientList from "../../pages/Admin/List.vue";
import ServiceDefinition from "../Products/ServiceDefinition.vue";

const componentDicionary = {
  products_list: ProductsList,
  product_form: ProductForm,
  company_form: CompanyForm,
  company_info: ShowCompany,
  checkout: Checkout,
  saloon: Saloon,
  table_form: TableForm,
  orders_list: OrdersList,
  show_order: ShowOrder,
  order_form: OrderForm,
  clients_list: ClientsList,
  client_form: ClientForm,
  daily_report: DailyReport,
  admin_clients: AdminClientList,
  product_service_definition: ServiceDefinition,
};

export default {
  name: "Main",

  components: {
    AdminClientList,
    Checkout,
    ClientForm,
    ClientsList,
    DailyReport,
    Header,
    OrderForm,
    OrdersList,
    ProductForm,
    ProductsList,
    Saloon,
    ServiceDefinition,
    ShowOrder,
    Sidebar,
    TableForm,
  },

  data() {
    return {
      name: "",
      setup: false,
    };
  },

  props: {
    componentName: {
      type: String,
      required: true,
    },
    componentData: {
      type: Array,
    },
    user: {
      type: Object,
      required: true,
    },
  },

  mounted() {
    this.name = this.user.user.email;

    console.log("aqui");
  },

  computed: {
    loadComponent() {
      return componentDicionary[this.componentName];
    },
  },
};
</script>

<style>
.main-panel {
  position: relative;
  float: right;
  width: calc(100% - 260px);
  transition: 0.33s, cubic-bezier(0.685, 0.0473, 0.346, 1);
}

.content {
  width: 100%;
  /* padding-right: 15px; */
  padding-left: 15px;
  margin-right: auto;
  margin-left: auto;
}

.main-panel > .content {
  margin-top: 80px;
  padding: 30px 15px;
  min-height: calc(100vh - 123px);
}
</style>
