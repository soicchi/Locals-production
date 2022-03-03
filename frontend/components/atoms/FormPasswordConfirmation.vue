<template>
  <v-text-field
    v-model="setPasswordConfirmation"
    label="パスワード（確認）"
    :rules="rules"
    :type="type"
    :append-icon="icon"
    :prepend-icon="mdiLock"
    placeholder="8文字以上"
    autocomplete="on"
    @click:append="show = !show"
  />
</template>

<script>
import { mdiLock, mdiEye, mdiEyeOff } from '@mdi/js'

export default {
  props: {
    passwordConfirmation: {
      type: String,
      required: true,
    },
  },
  data: () => ({
    show: false,
    mdiLock,
    mdiEye,
    mdiEyeOff,
  }),
  computed: {
    min () {
      return 8
    },
    rules () {
      return [
        v => !!v || '',
        v => v.length >= this.min || '',
      ]
    },
    icon () {
      return this.show ? this.mdiEye : mdiEyeOff
    },
    type () {
      return this.show ? 'text' : 'password'
    },
    setPasswordConfirmation: {
      get () { return this.passwordConfirmation },
      set (newVal) { return this.$emit('update:passwordConfirmation', newVal) },
    },
  },
}
</script>
