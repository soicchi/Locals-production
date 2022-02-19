<template>
  <v-btn
    color="mainColor"
    :loading="loading"
    :disabled="loading"
    @click="search"
  >
    検索する
  </v-btn>
</template>

<script>
export default {
  props: {
    loading: {
      type: Boolean,
      required: true,
      default: false,
    },
  },
  methods: {
    search () {
      this.$emit('search')
    },
  },
}
</script>
