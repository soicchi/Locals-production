<template>
  <v-container>
    <v-card class="pa-4">
      <v-row>
        <v-col cols="12">
          <MoleculesAdminFormCategory
            :category.sync="setCategory"
            @add-category="addCategory"
          />
        </v-col>
        <v-col cols="12">
          <MoleculesAdminCategoryList :categories="categories" />
        </v-col>
      </v-row>
    </v-card>
  </v-container>
</template>

<script>
export default {
  props: {
    categories: {
      type: Array,
      required: true,
    },
    category: {
      type: String,
      required: true,
      default: '',
    },
  },
  methods: {
    addCategory () {
      this.$emit('add-category')
    },
    setCategory: {
      get () { return this.category },
      set (newVal) { return this.$emit('update:category', newVal) },
    },
  },
}
</script>
