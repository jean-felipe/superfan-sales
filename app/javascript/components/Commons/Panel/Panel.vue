<template>
 <div class="card">
  <div class="row">
    <div class="col-md-12">
      <div class="card-content">
        <div class="header-content is-flex">
          <div class="media-left">
            <h4 class="card-title mt-0">{{ title }}</h4>
            <p class="card-category">{{ title_description }}</p>
          </div>
          <div></div>
          <div class="navbar-end">
            <div class="navbar-item">
            <a v-if="has_action_button" :href="action_path" class="button is-success new-button">
              {{ button_action_label }}
            </a>

            <button v-if="has_second_action_button" :href="second_action_path" class="button is-success new-button ml-2">
              {{ second_button_action_label }}
            </button>

            <button v-if="has_third_action_button" :href="third_action_path" class="button is-success new-button">
              {{ third_button_action_label }}
            </button>

            <button v-if="has_extra_action_button" :href="extra_action_path" class="button is-success new-button">
              {{ extra_button_action_label }}
            </button>


              <p v-if="has_input_search" class="control has-icons-left has-icons-right" style="margin-left: 10px;">
                <input type="search" class="input is-marginless ml-2" placeholder="Pesquisa" />
                <span class="icon is-small is-left">
                  <i class="fas fa-search"></i>
                </span>
              </p>
            </div>
          </div>
        </div>
        <hr />
        <div class='panel_content'>
          <slot></slot>
        </div>
      </div>
    </div>
  </div>
</div>

</template>
<script>
export default {
  name: 'Panel',
   props: {
    title: {
      type: String,
      required: true
    },
    title_description: {
      type: String,
      required: true
    },
    has_action_button: Boolean,
    action_path: String,
    button_action_label: String,
    has_second_action_button: Boolean,
    second_action_path: String,
    second_button_action_label: String,
    has_third_action_button: Boolean,
    third_action_path: String,
    third_button_action_label: String,
    has_extra_action_button: Boolean,
    extra_action_path: String,
    extra_button_action_label: String,
    has_input_search: Boolean
  },
}
</script>
<style lang="">

</style>
