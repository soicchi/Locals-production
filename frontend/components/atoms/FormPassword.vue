<template>
  <v-text-field
    v-model="setPassword"
    label="パスワード"
    :rules="rules"
    :counter="!noValidation"
    :type="type"
    :append-icon="icon"
    :prepend-icon="mdiLock"
    :placeholder="placeHolder"
    autocomplete="on"
    @click:append="show = !show"
  />
</template>

<script>
import { mdiLock, mdiEye, mdiEyeOff } from '@mdi/js'

export default {
  props: {
    noValidation: {
      type: Boolean,
      default: true,
    },
    password: {
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
    placeHolder () {
      return this.noValidation ? undefined : `${this.min}文字以上`
    },
    rules () {
      const requiredRule = v => !!v || ''
      const lengthRule = v => v.length >= this.min || ''
      return this.noValidation ? [requiredRule] : [requiredRule, lengthRule]
    },
    icon () {
      return this.show ? this.mdiEye : this.mdiEyeOff
    },
    type () {
      return this.show ? 'text' : 'password'
    },
    setPassword: {
      get () { return this.password },
      set (newVal) { return this.$emit('update:password', newVal) },
    },
  },
}
</script>
