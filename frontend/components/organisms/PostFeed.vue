<template>
  <div>
    <MoleculesPostCard
      v-for="post in posts"
      :key="post.id"
      :post="post"
      :icon-size="iconSize"
      :logged-in-user="loggedInUser"
      @destroy-post="destroyPost"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

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
    ...mapGetters({
      loggedInUser: 'user/loggedInUser',
    }),
    iconSize () {
      return 48
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
