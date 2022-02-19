<template>
  <v-btn
    color="mainColor"
    @click="reset"
  >
    クリア
  </v-btn>
</template>

<script>
export default {
  methods: {
    reset () {
      this.$emit('reset')
    },
  },
}
</script>
