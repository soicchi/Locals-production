<template>
  <v-text-field
    label='パスワード（確認）'
    v-model='setPasswordConfirmation'
    :rules='rules'
    :type='type'
    :append-icon='icon'
    prepend-icon='mdi-lock'
    @click:append='show = !show'
    placeholder='8文字以上'
    autocomplete="on"
  />
</template>

<script>
export default {
  props: {
    passwordConfirmation: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      show: false
    }
  },
  computed: {
    min() {
      return 8
    },
    rules() {
      return [
        v => !!v || '',
        v => v.length >= this.min || ''
      ]
    },
    icon() {
      return this.show ? 'mdi-eye' : 'mdi-eye-off'
    },
    type() {
      return this.show ? 'text' : 'password'
    },
    setPasswordConfirmation: {
      get() { return this.passwordConfirmation },
      set(newVal) { return this.$emit('update:passwordConfirmation', newVal) }
    }
  }
}
</script>