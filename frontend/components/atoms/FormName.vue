<template>
  <v-text-field
    v-model="setName"
    label="ユーザー名"
    :rules="rules"
    :counter="max"
    :prepend-icon="mdiAccount"
    placeholder="あなたの表示名"
  />
</template>

<script>
import { mdiAccount } from '@mdi/js'

export default {
  props: {
    name: {
      type: String,
      required: true,
    },
  },
  data: () => ({
    mdiAccount,
  }),
  computed: {
    max () {
      return 10
    },
    rules () {
      return [
        v => !!v || '',
        v => v.length <= this.max || `${this.max}以内で入力してください`,
      ]
    },
    setName: {
      get () { return this.name },
      set (newVal) { return this.$emit('update:name', newVal) },
    },
  },
}
</script>
