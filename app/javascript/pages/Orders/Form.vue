<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-md-12">
           <div class="card-content">
            <div class="media">
              <div class="header-content beerconsumptions">
                <div class="media-left">
                  <h4 class="card-title mt-0">Nova compra</h4>
                  <p>
                    <input type="radio" value="nome" v-model="newOrder.identification_type"> Nome
                    <input type="radio" value="cpf" v-model="newOrder.identification_type"> CPF
                    <input type="radio" value="code" v-model="newOrder.identification_type"> Código
                  </p>
                  <span></span>
                </div>

                <div>

                </div>
              </div>
            </div>
            <div class="card-body">
              <hr />

                <div class="field is-horizontal">
                  <div class="field-body">
                    <div class="field">
                      <label class="label">Cliente ({{newOrder.identification_type}})</label>
                      <div class="control is-expanded">
                        <input class="input is-marginless" type="text" v-if="newOrder.identification_type == 'cpf'" placeholder="Documento do cliente"
                          v-model="newOrder.identification" v-mask="'###.###.###-##'" required>

                        <input class="input is-marginless" type="text" v-if="newOrder.identification_type == 'nome'" placeholder="Nome do cliente"
                          v-model="newOrder.identification" required>
                        <input class="input is-marginless" type="text" v-if="newOrder.identification_type == 'code'" placeholder="Código do cliente"
                          v-model="newOrder.identification" required>
                      </div>
                  </div>

                  <div class="field">
                    <label class="label">Data</label>
                    <div class="control is-expanded">
                      <div class="is-fullwidth">
                        <input type="date"  class="input is-marginless" v-model="date" />
                      </div>
                    </div>
                  </div>
                  </div>
                </div>

                 <div class="field is-horizontal">
                  <div class="field-body">
                    <div class="field">
                      <label class="label">Produto</label>
                        <div class="control is-expanded">
                          <div class="is-fullwidth">
                        <input class="input is-marginless" type="text" placeholder="2223333"
                          v-model="searchProduct" required>
                           </div>
                        </div>
                    </div>

                   <div class="field">
                      <label class="label">Entrega</label>
                      <div class="control is-expanded">
                        <div class="select is-fullwidth">
                          <select name="delivery_type" v-model="newOrder.delivery_type">
                            <option v-for="type in deliveryTypes"
                              v-bind:key="type + '-name'"
                              v-bind:value="type">
                                {{ type }}
                            </option>
                          </select>

                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="products-list" v-if="productList" >
                  <table class="table is-bordered is-striped">
                    <tr>
                      <th>Nome</th>
                      <th>Preço</th>
                      <td>Ação</td>
                    </tr>

                    <tbody v-for="product in products" v-bind:key="product.id">
                      <tr>
                        <td>{{ product.name }} - {{ product.description }}</td>
                        <td>{{ product.price }}</td>
                        <td>
                          <button class="button is-success has-magin-bottom" @click="addProduct(product)">Adicionar</button>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>


              <div v-if="selectedProducts.length > 0">
                <hr />
                  <table class="table is-bordered is-striped">
                    <tr>
                      <th>Nome</th>
                      <th>Quantidade</th>
                      <th>Preço</th>
                      <th>Ações</th>
                    </tr>
                    <tbody v-for="product in selectedProducts" v-bind:key="product.id">
                      <tr>
                        <td>{{ product.name }} - {{ product.description }} {{ product.product_type }}</td>
                        <td>
                          <input type="number" v-model="product.quantity" class="input is-marginless quantity-input" />

                          <div class="service-configuration" v-if="product.product_type === 'service'">
                            <table class="table is-bordered is-striped">
                              <tr>
                                <th>Pagamento recorrente</th>
                                <th>Enviar cobranca</th>
                              </tr>
                            </table>
                          </div>
                          <div v-else></div>
                        </td>
                        <td>R$ {{ product.price }}</td>
                        <td>
                          <button class="button is-danger" @click="removeProduct(product)">Remover</button>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                  <h3>Total: R${{ newOrder.items.reduce((total, obj) => (obj.price * obj.quantity) + total, 0) }}</h3>
                </div>
                <hr />

                <div class="field" v-if="payment">
                  <h3>Pagamento</h3>
                  <div v-for="(payment, index) in paymentMethodsSelected" :key="index + '-methods'">
                    <div class="field is-horizontal">
                      <div class="field-body">
                      <div class="field">
                      <label class="label">Tipo</label>
                      <div class="control is-expanded">
                        <div class="select is-fullwidth">
                          <select name="product_type" v-model="payment.name">
                            <option v-for="method in paymentMethods"
                              v-bind:key="method + '-name'"
                              v-bind:value="method">
                                {{ method }}
                            </option>
                          </select>

                        </div>
                      </div>
                    </div>

                    <div class="field">
                      <label class="label">Valor</label>
                      <div class="control is-expanded">
                        <input class="input is-marginless" type="number"
                          v-model="payment.value" min="0" required>
                      </div>
                    </div>

                    <a @click="addPaymentMethods()" class="button is-sucess has-margin">
                      <span class="icon is-large">
                        <i class="fas fa-plus"></i>
                      </span>
                    </a>
                    </div>
                  </div>
                </div>
                </div>

                <div class="field is-grouped">
                  <div class="control" v-if="edition">
                    <button type="submit" class="button is-link">Editar Produto</button>
                  </div>
                  <div class="control" v-else>
                    <!-- <button type="submit" class="button is-link" @click="handleSubmit">Criar Pedido</button> -->
                    <button class="button is-success" @click="handleSubmit">Pagar</button>
                    <button class="button is-danger">Cancelar</button>

                  </div>

                </div>
            </div>

            <div>

            </div>
          </div>
        </div>
      </div>
    </div>
 </div>
</template>

<script>
import axios from 'axios'
import moment from 'moment'
import Datepicker from 'vuejs-datepicker';
import Swal from 'sweetalert2';

export default {
  name: 'OrderForm',
  components: { Datepicker },

  data() {
    return {
      newOrder: {
        identification: '',
        checkout_date: '',
        items: [],
        totalPrice: 0,
        payment_methods: [],
        delivery_type: 'Retirada',
        identification_type: 'nome',
      },
      searchProduct: [],
      products: [],
      paymentMethods: ['Débito', 'Crédito', 'Dinheiro', 'Pix'],
      deliveryTypes: ['Entrega', 'Retirada', 'Consumo no local'],
      productList: false,
      edition: false,
      payment: true,
      paymentMethodsSelected: [],
      date: moment().format("DD/MM/YYYY")
    }
  },

  props: {
    data: {
      type: Array,
      require: true
    },
  },

  watch: {
    searchProduct: function(val, oldVal) {
      if(val.length > 2) {
        this.getProducts(val)
      }
    },
    selectedProducts: function() {

    },

    paymentMethodsSelected() {
      this.blockRemoval = this.paymentMethodsSelected.length <= 1
    },

  },

  computed: {
    selectedProducts() {
      return this.newOrder.items
    },

  },

  methods: {
    handleSubmit() {
      this.newOrder.totalPrice = this.newOrder.items.reduce((total, obj) => (obj.price * obj.quantity) + total, 0)
      this.newOrder.payment_methods = this.paymentMethodsSelected

      let total_payed = this.newOrder.payment_methods.reduce((total, obj) => parseInt(obj.value) + total, 0)

      if(this.paymentMethodsSelected[0].name == null) {
        Swal.fire("Ainda não!", "Selecione pelo menos um pagamento!", "error")
      } else if(total_payed < this.newOrder.totalPrice) {
        Swal.fire("Ainda não!", "O total pago precisa ser igual ou maior ao preço devido!", "error")
      } else {
        axios.post('/api/v1/orders', {order: this.newOrder})
          .then((response) => {
            console.log(response)
            // // this.sendImages(response.data.id)

            Swal.fire("Parabéns!", "Pedido criado com sucesso!", "success")
              .then(() => {
                window.location = '/orders'
              })
          })
      }
    },

    getProducts(word) {
      axios.get('/api/v1/products?filter=' + word + '&fields=id,name,price,description,product_type' )
        .then(response => {
          this.products = response.data
          this.productList = true
        })
    },

    addPaymentMethods() {
      let checkEmptyLines = this.paymentMethodsSelected.filter(line => line.value === null)

      if (checkEmptyLines.length >= 1 && this.paymentMethodsSelected.length > 0) {
        return
      }

      this.paymentMethodsSelected.push({
        name: null,
        value: null,
      })
    },

    addProduct(product) {
      this.newOrder.items.push({
        id: product.id, name: product.name, quantity: product.quantity,
        price: product.price, product_type: product.product_type,
        description: product.description
      })
    },

    customFormatter(date) {
      return moment(date).format('MMMM Do YYYY, h:mm:ss a');
    },

    removeProduct(product) {
      let index = this.newOrder.items.indexOf(product)
      this.newOrder.items.splice(index, 1)
    }

  },

  mounted() {
    // this.categories = this.data[0].categories
    // this.subcategories = this.data[0].sub_categories
    this.addPaymentMethods()
  }
}
</script>

<style>
.img-preview {
  height: 300px;
  width: 300px;
  margin-right: 20px;
}

.preview {
  display: flex;
}

.has-margin {
  margin-top: auto;
}
</style>
