<template>
  <v-textarea
    v-model="setIntroduction"
    label="自己紹介"
    :rules="rules"
    :counter="max"
    prepend-icon="mdi-pencil"
  />
</template>

<script>
export default {
  props: {
    introduction: {
      type: String,
      required: true,
    },
  },
  computed: {
    max () {
      return 255
    },
    rules () {
      return [v => v.length <= this.max || `${this.max}文字以内にしてください。`]
    },
    setIntroduction: {
      get () { return this.introduction },
      set (newVal) { return this.$emit('update:introduction', newVal) },
    },
  },
}
</script>
