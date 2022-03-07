<template>
  <TemplatesTopPage
    :title="title"
    :posts="followingPosts"
  />
</template>

<script>
export default {
  computed: {
    title: () => '投稿一覧',
    followingPosts () {
      return this.$store.getters['post/posts']
    },
  },
  created () {
    this.$store.dispatch('category/getCategories')
    this.$store.dispatch('post/getFollowingPosts')
  },
}
</script>
