<template>
  <v-btn
    :disabled="loading"
    :loading="loading"
    rounded
    color="subColor"
    class="delete-btn"
    @click="deleteUser"
  >
    退会する
  </v-btn>
</template>

<script>
export default {
  data () {
    return {
      loading: false,
    }
  },
  methods: {
    deleteUser () {
      this.loading = true
      setTimeout(() => {
        this.loading = false
      }, 1500)
      this.$emit('delete-user')
    },
  },
}
</script>

<style lang="sass" scoped>
  .delete-btn
    @include commonBtn
</style>
