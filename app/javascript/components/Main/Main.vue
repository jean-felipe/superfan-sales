<template>
<div>
  <div class="wrapper" v-if="componentName != 'home'">
    <div class="dashboard">
      <Sidebar :user="user"/>
        <div class="main-panel">
          <Header :user="user"/>
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
import 'bulma/css/bulma.css';
// import 'bulma-o-steps/bulma-steps.css';

import Sidebar from '../Commons/Sidebar/Sidebar';
import Header from '../Commons/Header/Header';

import ProductsList from '../Products/List';
import ProductForm from '../Products/Form';

import CompanyForm from '../Companies/Form';
import ShowCompany from '../Companies/Show';

const componentDicionary = {
  products_list: ProductsList,
  product_form: ProductForm,
  company_form: CompanyForm,
  company_info: ShowCompany
};

export default {
  name: 'Main',

  components: {
    Header, Sidebar, ProductsList, ProductForm
  },

  data() {
    return {
      name: '',
      setup: false,
    }
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
    }
  },

  created() {
    this.name = this.user.email;
  },

  computed: {
    loadComponent() {
      return componentDicionary[this.componentName]
    }
  }
}
</script>

<style>
  .main-panel {
    position: relative;
    float: right;
    width: calc(100% - 260px);
    transition: .33s,cubic-bezier(.685,.0473,.346,1);
  }

  .content {
    width: 100%;
    /* padding-right: 15px; */
    padding-left: 15px;
    margin-right: auto;
    margin-left: auto;
  }

  .main-panel>.content {
    margin-top: 80px;
    padding: 30px 15px;
    min-height: calc(100vh - 123px);
}

</style>
