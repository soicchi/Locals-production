<template>
  <div>
    <v-btn
      v-if="!disliked"
      width="60px"
      icon
      plain
      retain-focus-on-click
      :loading="loading"
      :disabled="myPost || loading"
      @click="dislike"
    >
      <v-icon>
        mdi-thumb-down-outline
      </v-icon>
    </v-btn>
    <v-btn
      v-else
      width="60px"
      icon
      plain
      retain-focus-on-click
      :loading="loading"
      :disabled="myPost || loading"
      @click="undislike"
    >
      <v-icon color="#DD2C00">
        mdi-thumb-down
      </v-icon>
    </v-btn>
    {{ post.dislike_users.length }}
  </div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  props: {
    post: {
      type: Object,
      required: true,
    },
    loggedInUser: {
      type: Object,
      required: true,
    },
    disliked: {
      type: Boolean,
      required: true,
      default: false,
    },
    myPost: {
      type: Boolean,
      required: true,
      default: false,
    },
  },
  data () {
    return {
      loading: false,
    }
  },
  created () {
    this.loading = true
    setTimeout(() => {
      const dislikedState = this.loggedInUser.dislikedPosts.includes(this.post.id)
      if (dislikedState) {
        this.$emit('change-to-disliked')
      }
      this.loading = false
    }, 1500)
  },
  methods: {
    ...mapActions({
      addLoggedInUserDislikedPost: 'user/addLoggedInUserDislikedPost',
      removeLoggedInUserDislikedPost: 'user/removeLoggedInUserDislikedPost',
      addDislikeUser: 'post/addDislikeUser',
      removeDislikeUser: 'post/removeDislikeUser',
      setMessages: 'message/setMessages',
    }),
    async dislike () {
      await this.$axios.post('/dislikes', { post_id: this.post.id })
        .then(() => {
          this.$emit('change-to-disliked', this.post.id)
          this.addLoggedInUserDislikedPost(this.post.id)
          this.addDislikeUser(this.loggedInUser)
        })
        .catch((e) => {
          const message = [e.response.data.message]
          this.setMessages({ messages: message, type: 'error' })
        })
    },
    async undislike () {
      await this.$axios.delete(`/dislikes/${this.post.id}`)
        .then(() => {
          this.$emit('change-to-disliked', this.post.id)
          this.removeLoggedInUserDislikedPost(this.post.id)
          this.removeDislikeUser(this.loggedInUser)
        })
        .catch((e) => {
          const message = [e.response.data.message]
          this.setMessages({ messages: message, type: 'error' })
        })
    },
  },
}
</script>
