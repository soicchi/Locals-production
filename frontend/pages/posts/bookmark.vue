<template>
  <TemplatesBookMarkPage :title='title' />
</template>

<script>
export default {
  computed: {
    title() {
      return '保存した投稿'
    }
  },
  created() {
    this.$store.dispatch('bookMark/getBookMarks')
  }
}
</script>