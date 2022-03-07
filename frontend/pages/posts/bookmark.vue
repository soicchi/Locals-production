<template>
  <TemplatesBookMarkPage :title="title" />
</template>

<script>
export default {
  computed: {
    title () {
      return 'ブックマーク'
    },
  },
  created () {
    this.$store.dispatch('bookMark/getBookMarks')
  },
}
</script>
