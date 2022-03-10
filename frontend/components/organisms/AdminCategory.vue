<template>
  <v-card class="pa-4">
    <v-row>
      <v-col cols="12">
        <MoleculesAdminFormCategory
          v-model="setCategory"
          :category.sync="setCategory"
          @add-category="addCategory"
        />
      </v-col>
      <v-col cols="12">
        <MoleculesAdminCategoryList
          :categories="categories"
          @remove-category="removeCategory"
        />
      </v-col>
    </v-row>
  </v-card>
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
    },
  },
  computed: {
    setCategory: {
      get () { return this.category },
      set (newVal) { return this.$emit('update:category', newVal) },
    },
  },
  methods: {
    addCategory () {
      this.$emit('add-category')
    },
    removeCategory (categoryId) {
      this.$emit('remove-category', categoryId)
    },
  },
}
</script>
