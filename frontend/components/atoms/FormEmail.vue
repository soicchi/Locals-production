<template>
  <v-text-field
    v-model="setEmail"
    label="メールアドレス"
    :rules="rules"
    type="email"
    :prepend-icon="mdiEmail"
    :placeholder="placeHolder"
  />
</template>

<script>
import { mdiEmail } from '@mdi/js'

export default {
  props: {
    email: {
      type: String,
      required: true,
    },
    noValidation: {
      type: Boolean,
      default: true,
    },
  },
  data: () => ({
    mdiEmail,
  }),
  computed: {
    rules () {
      return [
        v => !!v || '',
        v => /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(v) || '',
      ]
    },
    setEmail: {
      get () { return this.email },
      set (newVal) { return this.$emit('update:email', newVal) },
    },
    placeHolder () {
      return this.noValidation ? undefined : 'example@example.com'
    },
  },
}
</script>
