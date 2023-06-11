<template>
  <div>
    <Panel
      title="Configuração de serviço"
      title_description="Manage your authored books"
      :has_action_button="true"
      button_action_label="New Book"
      action_path="books/new"
      :has_input_search="false">

      <div class="form">
        <div class="field">
            <label class="label">Duracao quantidade</label>
          <div class="control is-expanded">
            <div class="is-fullwidth">
              <input class="input is-marginless" type="number" v-model="newProduct.duration_quantity"
                placeholder="3" min="0" step=".01" require>
            </div>
          </div>
        </div>
      </div>

    </Panel>
  </div>
</template>
<script>
import Panel from "../Commons/Panel/Panel.vue"
export default {
  name: 'ServiceDefinition',

  components: { Panel },

  data() {
    return {
      productConfigs: {
        registrationRequired: false,
        registrationPrice: 0,
        subscription: false,
        subscriptionPrice: 0,na
        subscriptionPaymentDay: 1,
        notifyPaymentDay: false,

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
