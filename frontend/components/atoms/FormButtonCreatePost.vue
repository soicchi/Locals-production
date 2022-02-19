<template>
  <v-btn
    :disabled="!isValid || loading"
    :loading="loading"
    rounded
    color="mainColor"
    class="post-btn"
    @click="createPost"
  >
    投稿する
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
    createPost () {
      this.loading = true
      setTimeout(() => {
        this.loading = false
      }, 1500)
      this.$emit('create-post')
    },
  },
}
</script>

<style lang="sass" scoped>
  .post-btn
    @include commonBtn
</style>
