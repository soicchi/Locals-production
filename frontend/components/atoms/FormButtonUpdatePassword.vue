<template>
  <v-btn
    :disabled="!isValid || loading"
    :loading="loading"
    rounded
    color="mainColor"
    class="update-btn"
    @click="update"
  >
    変更する
  </v-btn>
</template>

<script>
export default {
  props: {
    isValid: {
      type: Boolean,
      required: true,
      default: false,
    },
    loading: {
      type: Boolean,
      required: true,
      default: false,
    },
  },
  methods: {
    update () {
      this.$emit('update')
    },
  },
}
</script>

<style lang="sass" scoped>
  .update-btn
    @include commonBtn
</style>
