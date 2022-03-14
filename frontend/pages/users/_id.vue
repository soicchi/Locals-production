<template>
  <div>
    <TemplatesUserPage
      v-if="matchName"
      :posts="user.posts"
      :logged-in-user="loggedInUser"
      :icon-size="iconSize"
      :post-card-width="postCardWidth"
      @destroy-post="destroyPost"
    />
    <NuxtChild
      :user="user"
      :logged-in-user="loggedInUser"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      loggedInUser: 'user/loggedInUser',
      user: 'user/user',
    }),
    matchName () {
      return this.$route.path === `/users/${this.user.id}`
    },
    postCardWidth () {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs': return '100%'
        case 'sm': return '80%'
        case 'md': return '80%'
      }
      return '45%'
    },
    iconSize: () => 48,
  },
  created () {
    const userId = this.$route.params.id
    this.$store.dispatch('user/getUser', userId)
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
