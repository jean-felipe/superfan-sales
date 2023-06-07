<template>
  <div>
    <Panel
      title="Configuração de serviço"
      title_description="Manage your authored books"
      :has_action_button="true"
      button_action_label="New Book"
      action_path="books/new"
      :has_input_search="false">


    </Panel>
  </div>
</template>
<script>
import Panel from "../Commons/Panel/Panel.vue"
export default {
  name: 'ServiceDefinition',

  data() {
    return {
      productConfigs: {

      }
    }
  },

  props: {
    data: {
      type: Object
    }
  },

  mounted() {
    console.log(this.data)
  }
}
</script>
<style>

</style>
