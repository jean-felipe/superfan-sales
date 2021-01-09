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
                    <label class="label">Cliente(CPF)</label>
                    <div class="control is-expanded">
                      <input class="input is-marginless" type="text" placeholder="Nome do negócio" 
                        v-model="newOrder.identification" required>
                    </div>
                  </div>

                  <div class="field">
                    <label class="label">Data</label>
                    <div class="control is-expanded">
                      <div class="is-fullwidth">
                        <input class="input is-marginless" type="date" placeholder="Nome do negócio" 
                          v-model="newOrder.checkout_date" required>
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
                        <td>{{ product.name }}</td>
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
                    </tr>
                    <tbody v-for="product in selectedProducts" v-bind:key="product.id">
                      <tr>
                        <td>{{ product.name }}</td>
                        <td>
                          <input type="number" v-model="product.quantity" class="input is-marginless quantity-input" />
                        </td>
                        <td>{{ product.price }}</td>
                      </tr>
                    </tbody>
                  </table>
                  <h3>Total: R${{ newOrder.items.reduce((total, obj) => (obj.price * obj.quantity) + total, 0) }}</h3>
                </div>
                <hr />

                <div class="field" v-if="payment">
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

                    <a @click="addPaymentMethods()" class="button is-sucess">+</a>
                    </div>
                  </div>
                </div>
                </div>
              
                <div class="field is-grouped">
                  <div class="control" v-if="edition">
                    <button type="submit" class="button is-link">Editar Produto</button>
                  </div>
                  <div class="control" v-else>
                    <button type="submit" class="button is-link" @click="handleSubmit">Criar Pedido</button>
                    <button class="button is-success" @click="payment = true">Pagar</button>
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


export default {
  name: 'OrderForm',

  data() {
    return {
      newOrder: {
        identification: '',
        checkout_date: '',
        items: [],
        totalPrice: '',
        payment_methods: ''
      },
      searchProduct: [],
      products: [],
      paymentMethods: ['Débito', 'Crédito', 'Dinheiro'],
      productList: false,
      edition: false,
      payment: false,
      paymentMethodsSelected: [],
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
      axios.post('/api/v1/orders', {order: this.newOrder})
        .then((response) => {
          console.log(response)
          // // this.sendImages(response.data.id)

          this.$swal("Parabéns!", "Produto criado com sucesso!", "success")
            .then(() => {
              window.location = '/orders'
            })
        })
    },

    getProducts(word) {
      axios.get('/api/v1/products?filter=' + word )
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
      this.newOrder.items.push({id: product.id, name: product.name, quantity: 1, price: product.price })
    },

   
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
</style>