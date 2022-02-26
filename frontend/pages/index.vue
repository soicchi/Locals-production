<template>
  <TemplatesTopPage :title="title" />
</template>

<script>
export default {
  computed: {
    title: () => '投稿一覧',
  },
  created () {
    if (this.$auth.loggedIn) {
      // 下記メソッドをstoreファイル上でまとめる
      this.$store.dispatch('post/getFollowingPosts')
      this.$store.dispatch('user/setLoggedInUserBookMarks')
      this.$store.dispatch('user/setLoggedInUserLikedPosts')
      this.$store.dispatch('user/setLoggedInUserDislikedPosts')
    } else {
      this.$store.dispatch('post/getPosts')
      this.$store.dispatch('category/getCategories')
    }
  },
}
</script>
