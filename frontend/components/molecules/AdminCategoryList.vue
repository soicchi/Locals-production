<template>
  <v-row>
    <v-col
      v-for="category in categories"
      :key="category.id"
      cols="4"
    >
      <AtomsAdminCategoryItem
        :category="category"
        @remove-category="removeCategory"
      />
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: {
    categories: {
      type: Array,
      required: true,
    },
  },
  methods: {
    removeCategory (categoryId) {
      this.$emit('remove-category', categoryId)
    },
  },
}
</script>
