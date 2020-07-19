<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-md-12">
          <div class="card-content">
            <div class="media">
              <div class="header-content beerconsumptions">
                <div class="media-left">
                  <h4 class="card-title mt-0">Salão</h4>
                </div>
               
                <div>
                </div>
              </div>
            </div>
            <div class="card-body">
            </div>
            
            <div>
               <div class="tabs is-toggle">
                  <ul class="tabs-saloon">
                    <li :class="{ 'is-active': displayAction == 'saloon' }">
                      <a @click="displayAction = 'saloon'">
                        <span class="icon is-small"><i class="fas fa-clipboard-list"></i></span>
                        <span>Salão</span>
                      </a>
                    </li>
                    <li :class="{ 'is-active': displayAction == 'management' }">
                      <a @click="displayAction = 'management'">
                        <span class="icon is-small"><i class="fas fa-chart-line"></i></span>
                        <span>Gerenciar mesas</span>
                      </a>
                    </li>
                  
                  
                  </ul>
                </div>
              <Management v-if="displayAction == 'management'" :tables="tables"/>
              <SaloonTables v-if="displayAction == 'saloon'" :tables="tables"/>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import SaloonTables from '../Saloon/SaloonTables/List';
import Management from '../Saloon/Management/SaloonManagement';

export default {
  name: "Saloon",
  components: { SaloonTables, Management},

  data() {
    return {
      tables: [],
      displayAction: 'saloon'
    }
  },

  props: {
    data: {
      type: Array
    }
  },

  mounted() {
    this.tables = this.data[0]
  }

}
</script>

<style scoped>
.tabs-saloon {
  margin-left: 0;
}
</style>