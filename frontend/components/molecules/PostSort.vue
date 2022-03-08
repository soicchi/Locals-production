<template>
  <v-select
    outlined
    :items="sortList"
    v-model="setSortVal"
    color="#9E9A94"
  />
</template>

<script>
export default {
  props: {
    sortList: {
      type: Array,
      required: true,
    },
    sortVal: {
      type: String,
      required: true,
      default: '最新順'
    }
  },
  computed: {
    setSortVal: {
      get () { return this.sortVal },
      set (newVal) { return this.$emit('update:sortVal', newVal) }
    }
  },
}
</script>