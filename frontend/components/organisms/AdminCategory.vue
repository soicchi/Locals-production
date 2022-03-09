<template>
  <v-container>
    <v-card class="pa-4">
      <v-row>
        <v-col cols="12">
          <MoleculesAdminFormCategory
            :category.sync="category"
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
    }
  },
  methods: {
    addCategory () {
      this.$emit('add-category')
    }
  }
}
</script>