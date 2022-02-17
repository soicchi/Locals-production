<template>
  <v-btn
    :disabled="!isValid || loading"
    :loading="loading"
    rounded
    color="mainColor"
    class="signin-btn"
    width="50%"
    height="40px"
    @click="signIn"
  >
    ログイン
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
    isValid: {
      type: Boolean,
      required: true,
      default: false,
    },
  },
  methods: {
    signIn () {
      this.$emit('sign-in')
    },
  },
}
</script>

<style lang="sass" scoped>
  .signin-btn
    @include commonBtn
</style>
