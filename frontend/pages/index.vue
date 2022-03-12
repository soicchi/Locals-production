<template>
  <TemplatesTopPage
    :page-title="pageTitle"
    :posts="posts"
    :logged-in-user="loggedInUser"
    :icon-size="iconSize"
    :sort-width="sortWidth"
    :post-card-width="postCardWidth"
    :sort-val.sync="sortVal"
    :sort-list="sortList"
    @destroy-post="destroyPost"
  />
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  data: () => ({
    sortVal: '',
  }),
  computed: {
    ...mapGetters({
      posts: 'post/posts',
      loggedInUser: 'user/loggedInUser',
    }),
    sortWidth () {
      return this.$vuetify.breakpoint.xs ? '40%' : '100%'
    },
    postCardWidth () {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs': return '100%'
        case 'sm': return '80%'
        case 'md': return '80%'
      }
      return '45%'
    },
    sortList () {
      return ['最新順', 'また行きたい順(高)']
    },
    pageTitle: () => 'すべての投稿',
    iconSize: () => 48,
  },
  created () {
    if (this.$auth.loggedIn) {
      this.$store.dispatch('user/getLoggedInUser')
    }
    this.$store.dispatch('post/getPosts')
    this.$store.dispatch('category/getCategories')
    this.sortVal = '最新順'
  },
  watch: {
    sortVal () {
      if (this.sortVal === this.sortList[0]) {
        this.$store.dispatch('post/newSort')
      } else if (this.sortVal === this.sortList[1]) {
        this.$store.dispatch('post/likeSort')
      }
    }
  },
  methods: {
    ...mapActions({
      setMessages: 'message/setMessages',
      setPosts: 'post/setPosts',
    }),
    async destroyPost (post) {
      if (window.confirm('投稿を削除しますか')) {
        await this.$axios.delete(`/posts/${post.id}`)
          .then((res) => {
            this.$store.dispatch('post/removePost', post)
            const message = [res.data.message]
            this.$store.dispatch('message/setMessages', { messages: message, type: 'success' })
          })
      }
    },
  },
}
</script>
