<template>
  <div>
    <MoleculesPostCard
      v-for="post in posts"
      :key="post.id"
      :post="post"
      :icon-size="iconSize"
      :logged-in-user="loggedInUser"
      @destroy-post="destroyPost"
    >
      <template #post-card-user-name>
        <AtomsUserName :user="post.user" />
      </template>
    </MoleculesPostCard>
  </div>
</template>

<script>
export default {
  props: {
    posts: {
      type: Array,
      required: true,
    },
  },
  data () {
    return {
      loading: false,
    }
  },
  computed: {
    iconSize () {
      return this.$vuetify.breakpoint.xs ? '40' : '60'
    },
    loggedInUser () {
      return this.$store.getters['user/loggedInUser']
    },
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
