<template>
  <TemplatesTopPage
    :title="title"
    :posts="posts"
  />
</template>

<script>
export default {
  computed: {
    title: () => '投稿一覧',
    posts () {
      return this.$store.getters['post/posts']
    },
  },
  created () {
    if (this.$auth.loggedIn) {
      this.$store.dispatch('user/getLoggedInUser')
      this.$store.dispatch('post/getFollowingPosts')
    } else {
      this.$store.dispatch('post/getPosts')
      this.$store.dispatch('category/getCategories')
    }
  },
}
</script>
