<template>
  <v-select
    v-model="setSortVal"
    outlined
    :items="sortList"
    color="#9E9A94"
    rounded
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
    },
  },
  computed: {
    setSortVal: {
      get () { return this.sortVal },
      set (newVal) { return this.$emit('update:sortVal', newVal) },
    },
  },
}
</script>
