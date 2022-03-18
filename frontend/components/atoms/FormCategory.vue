<template>
  <v-select
    v-model="setCategory"
    multiple
    item-value="id"
    item-text="name"
    :items="categoryItems"
    prepend-icon="mdi-food-fork-drink"
    chips
    deletable-chips
    placeholder="カテゴリーを選択"
  />
</template>

<script>
export default {
  props: {
    categoryIds: {
      type: Array,
      required: true,
    },
    categoryItems: {
      type: Array,
      required: true,
    },
  },
  computed: {
    setCategory: {
      get () { return this.categoryIds },
      set (newVal) { return this.$emit('update:category-ids', newVal) },
    },
  },
}
</script>
