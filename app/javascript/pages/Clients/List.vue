<template>
  <div>

    <Panel
      title="Gerenciamento dos Clientes"
      title_description="Gerencie seus clientes"
      :has_action_button="true"
      button_action_label="Novo Cliente"
      action_path="/clients/new"
      :has_input_search="false">
        <div class="tabs is-toggle">
          <ul>
            <li class="is-active">
              <a @click="setComponentToShow('list')">
                <span class="icon is-small"><i class="fas fa-image" aria-hidden="true"></i></span>
                <span>Lista</span>
              </a>
            </li>
            <li>
              <a @click="setComponentToShow('resume')">
                <span class="icon is-small"><i class="fas fa-music" aria-hidden="true"></i></span>
                <span>Resumo</span>
              </a>
            </li>
          </ul>
        </div>
        <div>
          <Table :headers="tableHeaders"
            :elements="clients" url="/clients"
            :hasDeleteAction="hasDeleteAction"
            :hasEditAction="hasEditAction"
            v-if="componentToShow == 'list'"
          />

          <Resume v-if="componentToShow == 'resume'" />
        </div>
    </Panel>
  </div>
</template>

<script>
import Table from '../../components/Commons/Table/Table.vue';
import Panel from '../../components//Commons//Panel/Panel.vue';

import Resume from './Resume.vue';

export default {
  name: 'ClientsList',
  components: {Table, Panel, Resume},

  data() {
    return {
      clients: [],
      hasDeleteAction: false,
      hasEditAction: true,
      componentToShow: 'list',
      tableHeaders: [
        "#", "Código", "Nome", "E-mail", "Documento", "Genero"
      ]
    }
  },
  props: {
    data: {
      type: Array
    }
  },

  methods: {
    newClient() {
      window.location = '/clients/new'
    },

    setComponentToShow(text) {
      this.componentToShow = text;
    }
  },

  mounted() {
    this.clients = this.data[0].clients
  }
}
</script>
