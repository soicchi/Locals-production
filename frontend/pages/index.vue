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
      this.$store.dispatch('user/setLoggedInUserInfo')
    } else {
      this.$store.dispatch('post/getPosts')
      this.$store.dispatch('category/getCategories')
    }
  },
}
</script>
