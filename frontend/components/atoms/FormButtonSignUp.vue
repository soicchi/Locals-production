<template>
  <v-btn
    :disabled='!isValid || loading'
    :loading='loading'
    rounded
    color='mainColor'
    class='signup-btn'
    width='50%'
    height='40px'
    @click='signUp'
  >
    登録する
  </v-btn>
</template>

<script>
export default {
  props: {
    loading: {
      type: Boolean,
      required: true,
      default: false
    },
    isValid: {
      type: Boolean,
      required: true,
      default: false
    }
  },
  methods: {
    signUp() {
      this.$emit('sign-up')
    }
  }
}
</script>

<style lang="sass" scoped>
  .signup-btn
    @include commonBtn
</style>