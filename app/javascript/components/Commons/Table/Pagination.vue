<template>
  <nav class="pagination" role="navigation" aria-label="pagination">
    <!-- <a class="pagination-previous">Anterior</a>
    <a class="pagination-next">Proxima</a> -->
    <ul class="pagination-list" style="list-style: none;">
      <li v-for="page in pages" v-bind:key="page">
        <a class="pagination-link is-current" aria-label="Goto page 1" aria-current="page" v-if="currentPage == page">{{page}}</a>
        <a class="pagination-link" aria-label="Goto page 1" v-else @click="changePage(page)">{{page}}</a>
      </li>
     
    </ul>
  </nav>
</template>

<script>
export default {
  name: 'Pagination',

  props: {
    pages: {
      type: Number,
      required: true,
    },
    currentPage: {
      type: Number
    }
  },

  methods: {
    changePage(page) {
      this.$emit('changePage', page)
    }
  }
}
</script>
