<template>
  <div>
    <table class="table is-bordered is-striped">
      <thead>
        <tr>
          <th v-for="header in headers" v-bind:key="header">{{ header }}</th>
          <th>Ações</th>
        </tr>
      </thead>
      <tbody v-for="element in elements" v-bind:key="element.id">
        <tr>
          <td v-for="key in element" v-bind:key="key">
            {{ key }}
          </td>
          <td>
            <button class="button is-info" @click="editElement(element.id)">
              <i class="fas fa-edit"></i>
            </button>
            <button class="button is-danger" @click="excludeElement(element.id)">
              <i class="fas fa-trash-alt"></i>
            </button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Table',

  props: {
    headers: {
      type: Array,
      required: true,
    },
    elements: {
      type: Array,
      required: true
    },
    url: {
      type: String
    }
  },

  methods: {
    editElement(id) {
      window.location = this.url + '/' + id + '/edit'
    },

    excludeElement(id) {
      this.$swal({
        title: "Confirma exclusão?",
        text: "Se excluir não será possivel recuperar os dados desse produto!",
        icon: "warning",
        buttons: ['Não', 'Sim'],
        dangerMode: true,
      })
      .then((willDelete) => {
        if (willDelete) {
          axios.delete('api/v1' + this.url, { id: id })
            .then(() => {
              swal("Poof! produto removido com sucesso!", {
                icon: "success",
              });
            })
        } else {
          swal("Produto não exluido");
        }
      });
    }
  },

  mounted() {
    console.log(this.elements)
    
  }
  
}
</script>

<style>

</style>
