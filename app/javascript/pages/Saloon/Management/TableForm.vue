<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-md-12">
          <div class="card-content">
            <div class="media">
              <div class="header-content beerconsumptions">
                <div class="media-left">
                  <h4 class="card-title mt-0">Cadastro de Mesas</h4>
                </div>

                <div></div>
              </div>
            </div>
            <div class="card-body">
              <hr />

              <form @submit.prevent="handleSubmit">
                <div class="field is-horizontal">
                  <div class="field-body">
                    <div class="field">
                      <label class="label">Nome*</label>
                      <div class="control is-expanded">
                        <input
                          class="input is-marginless"
                          type="text"
                          placeholder="Nome do negócio"
                          v-model="newTable.name"
                          required
                        />
                      </div>
                    </div>

                    <div class="field">
                      <label class="label">Lugares</label>
                      <div class="control is-expanded">
                        <div class="is-fullwidth">
                          <input
                            class="input is-marginless"
                            type="number"
                            placeholder="Nome do negócio"
                            v-model="newTable.places"
                            required
                          />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="field is-horizontal">
                  <div class="field-body">
                    <div class="field">
                      <label class="label">Status</label>
                      <div class="control is-expanded">
                        <div class="select is-fullwidth">
                          <select name="product_type" v-model="newTable.status">
                            <option v-for="status in statuses" v-bind:key="status">
                              {{ status }}
                            </option>
                          </select>
                        </div>
                      </div>
                    </div>

                    <div class="field"></div>
                  </div>
                </div>
                <hr />

                <div class="field is-grouped">
                  <div class="control" v-if="edition">
                    <button type="submit" class="button is-link">Editar Mesa</button>
                  </div>
                  <div class="control" v-else>
                    <button type="submit" class="button is-link">Criar</button>
                  </div>
                  <div class="control">
                    <button class="button is-link is-light">Cancelar</button>
                  </div>
                </div>
              </form>
            </div>

            <div></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Swal from "sweetalert2";

export default {
  name: "TableForm",

  data() {
    return {
      statuses: ["Ativa", "Inativa"],
      edition: false,
      newTable: {
        name: "",
        places: "",
        status: "",
      },
    };
  },

  props: {
    data: {
      type: Array,
      require: true,
    },
  },

  methods: {
    handleSubmit() {
      this.newTable.status = this.newTable.status == "Dísponivel" ? "active" : "inactive";

      axios.post("/api/v1/tables", this.newTable).then((response) => {
        console.log(response);
        // // this.sendImages(response.data.id)

        Swal.fire("Parabéns!", "Mesa cadastrada com sucesso!", "success").then(() => {
          window.location = "/saloon";
        });
      });
    },
  },
};
</script>
