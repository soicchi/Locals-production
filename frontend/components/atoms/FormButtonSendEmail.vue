<template>
  <v-btn
    rounded
    placeholder="メールアドレスを入力"
    label="送信用メールアドレス"
    class="send-email"
    color="mainColor"
    :disabled="!isValid || loading"
    :loading="loading"
    width="50%"
    height="40px"
    @click="sendEmail"
  >
    送信
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
  computed: {
    setEmail: {
      get () { return this.email },
      set (newVal) { return this.$emit('update:email', newVal) },
    },
  },
  methods: {
    sendEmail () {
      this.$emit('send-email')
    },
  },
}
</script>

<style lang="sass" scoped>
  .send-email
    @include commonBtn
</style>
