<template>
  <v-textarea
    v-model="setComment"
    label="コメント"
    :rules="rules"
    prepend-icon="mdi-pencil"
    placeholder="お店に対するコメントを記入"
  />
</template>

<script>
export default {
  props: {
    comment: {
      type: String,
      required: true,
    },
  },
  computed: {
    setComment: {
      get () { return this.comment },
      set (newVal) { return this.$emit('update:comment', newVal) },
    },
    rules () {
      return [v => !!v || '']
    },
  },
}
</script>
