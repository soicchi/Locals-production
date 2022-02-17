<template>
  <TemplatesTopPage
    :title='title'
    :posts='allPosts'
  />
</template>

<script>
export default {
  computed: {
    title: () => 'すべての投稿',
    allPosts() {
      return this.$store.getters['post/posts']
    }
  },
  created() {
    this.$store.dispatch('post/getPosts')
    this.$store.dispatch('category/getCategories')
    this.$store.dispatch('user/setLoggedInUserBookMarks')
    this.$store.dispatch('user/setLoggedInUserLikedPosts')
  }
}
</script>