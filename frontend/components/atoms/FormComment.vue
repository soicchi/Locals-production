<template>
  <v-textarea
    v-model="setComment"
    label="コメント"
    :rules="rules"
    :prepend-icon="mdiPencil"
    placeholder="お店に対するコメントを記入"
  />
</template>

<script>
import { mdiPencil } from '@mdi/js'

export default {
  props: {
    comment: {
      type: String,
      required: true,
    },
  },
  data: () => ({
    mdiPencil,
  }),
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
