<template>
  <v-snackbar
    :value="existed"
    transition="slide-x-reverse-transition"
    right
    top
    outlined
    :color="type"
  >
    <div
      v-for="(message, i) in messages"
      :key="i"
      class="ml-5 font-weight-bold"
    >
      <template v-if="type === 'success'">
        <v-icon :color="type">
          mdi-checkbox-marked-circle
        </v-icon> <span class="success-message">{{ message }}</span>
      </template>
      <template v-if="type === 'error'">
        <v-icon :color="type">
          mdi-alert-circle
        </v-icon> <span class="error-message">{{ message }}</span>
      </template>
    </div>
  </v-snackbar>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      messages: 'message/messages',
      type: 'message/type',
      existed: 'message/existed',
    }),
  },
  successStatus () {
    return this.type === 'success'
  },
  errorStatus () {
    return this.type === 'error'
  },
}
</script>

<style lang="sass" scoped>
  .success-message
    font-color: '#294e0e'
  .error-message
    font-color: '#621616'
</style>
