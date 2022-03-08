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
  },
  data () {
    return {
      loading: false,
    }
  },
  methods: {
    update () {
      this.loading = true
      setTimeout(() => {
        this.loading = false
      }, 5000)
      this.$emit('update')
    },
  },
}
</script>

<style lang="sass" scoped>
  .update-btn
    @include commonBtn
</style>
