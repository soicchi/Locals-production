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
import { mapGetters } from 'vuex'

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
    pageTitle: () => '投稿一覧',
    iconSize: () => 48,
  },
  watch: {
    sortVal () {
      if (this.sortVal === this.sortList[0]) {
        this.$store.dispatch('post/newSort')
      } else if (this.sortVal === this.sortList[1]) {
        this.$store.dispatch('post/likeSort')
      }
    },
  },
  created () {
    this.$store.dispatch('category/getCategories')
    this.$store.dispatch('post/getFollowingPosts')
    this.sortVal = '最新順'
  },
  methods: {
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
