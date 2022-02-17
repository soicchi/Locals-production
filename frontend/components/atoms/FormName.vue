<template>
  <v-text-field
    v-model="setName"
    label="ユーザー名"
    :rules="rules"
    :counter="max"
    prepend-icon="mdi-account"
    placeholder="あなたの表示名"
  />
</template>

<script>
export default {
  props: {
    name: {
      type: String,
      required: true,
    },
  },
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
