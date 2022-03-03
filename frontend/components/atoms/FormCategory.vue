<template>
  <v-select
    v-model="setCategory"
    multiple
    item-value="id"
    item-text="name"
    :items="categoryItems"
    :prepend-icon="mdiFoodForkDrink"
    chips
    placeholder="カテゴリーを選択"
  />
</template>

<script>
import { mdiFoodForkDrink } from '@mdi/js'

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
  data: () => ({
    mdiFoodForkDrink,
  }),
  computed: {
    setCategory: {
      get () { return this.categoryIds },
      set (newVal) { return this.$emit('update:category-ids', newVal) },
    },
  },
}
</script>
