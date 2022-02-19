<template>
  <v-btn
    :disabled="disabled || loading"
    :loading="loading"
    rounded
    color="mainColor"
    class="update-btn"
    @click="update"
  >
    更新する
  </v-btn>
</template>

<script>
export default {
  props: {
    disabled: {
      type: Boolean,
      required: true,
      default: true,
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
      }, 1500)
      this.$emit('update')
    },
  },
}
</script>

<style lang="sass" scoped>
  .update-btn
    @include commonBtn
</style>
