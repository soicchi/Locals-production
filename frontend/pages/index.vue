<template>
  <TemplatesTopPage
    :title="title"
    :posts="posts"
  />
</template>

<script>
export default {
  computed: {
    title: () => 'すべての投稿',
    posts () {
      return this.$store.getters['post/posts']
    },
  },
  created () {
    if (this.$auth.loggedIn) {
      this.$store.dispatch('user/getLoggedInUser')
    }
    this.$store.dispatch('post/getPosts')
    this.$store.dispatch('category/getCategories')
  },
}
</script>
