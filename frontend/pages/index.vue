<template>
  <TemplatesTopPage
    :title='title'
    :posts='posts'  
  />
</template>

<script>
export default {
  auth: false,
  layout({ store }) {
    return store.state.auth.loggedIn ? 'default' : 'beforeLogin'
  },
  computed: {
    title: () => '投稿一覧',
    posts() {
      return this.$store.getters['post/posts']
    }
  },
  created() {
    if (this.$auth.loggedIn) {
      // 下記メソッドをstoreファイル上でまとめる
      this.$store.dispatch('post/getFollowingPosts')
      this.$store.dispatch('user/setLoggedInUserBookMarks')
      this.$store.dispatch('user/setLoggedInUserLikedPosts')
      this.$store.dispatch('user/setLoggedInUserDislikedPosts')
    } else {
      this.$store.dispatch('post/getPosts')
    }
  }
}
</script>