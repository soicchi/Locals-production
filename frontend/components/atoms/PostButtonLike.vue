<template>
  <div>
    <div
      v-if="!$vuetify.breakpoint.xs"
      class="d-flex justify-center align-center"  
    >
      <v-btn
        v-if="!liked"
        width="70px"
        icon
        plain
        :disabled="myPost || loading || !$auth.loggedIn"
        :loading="loading"
        retain-focus-on-click
        @click="like"
      >
        <v-icon>
          mdi-thumb-up-outline
        </v-icon>
      </v-btn>
      <v-btn
        v-else
        width="70px"
        icon
        plain
        :disabled="myPost || loading || !$auth.loggedIn"
        :loading="loading"
        retain-focus-on-click
        @click="unlike"
      >
        <v-icon color="mainColor">
          mdi-thumb-up
        </v-icon>
      </v-btn>
      <span>
        {{ post.like_users.length }}
      </span>
    </div>
    <div
      v-else
      class="d-flex justify-space-around align-center"  
    >
      <div>
        <v-btn
          v-if="!liked"
          width="100%"
          icon
          plain
          :disabled="myPost || loading || !$auth.loggedIn"
          :loading="loading"
          retain-focus-on-click
          @click="like"
        >
          <v-icon>
            mdi-thumb-up-outline
          </v-icon>
        </v-btn>
        <v-btn
          v-else
          width="100%"
          icon
          plain
          :disabled="myPost || loading || !$auth.loggedIn"
          :loading="loading"
          retain-focus-on-click
          @click="unlike"
        >
          <v-icon color="#2962FF">
            mdi-thumb-up
          </v-icon>
        </v-btn>
      </div>
      <div class="text-center">
        {{ post.like_users.length }}
      </div>
    </div>
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
    liked: {
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
    if (this.$auth.loggedIn) {
      this.loading = true
      setTimeout(() => {
        const likedState = this.loggedInUser.likedPosts.includes(this.post.id)
        if (likedState) {
          // this.liked = true
          this.$emit('change-to-liked')
        }
        this.loading = false
      }, 1500)
    }
  },
  methods: {
    ...mapActions({
      addLoggedInUserLikedPost: 'user/addLoggedInUserLikedPost',
      removeLoggedInUserLikedPost: 'user/removeLoggedInUserLikedPost',
      addLikeUser: 'post/addLikeUser',
      removeLikeUser: 'post/removeLikeUser',
      setMessages: 'message/setMessages',
    }),
    async like () {
      await this.$axios.post('/likes', { post_id: this.post.id })
        .then(() => {
          this.$emit('change-to-liked', this.post.id)
          this.addLoggedInUserLikedPost(this.post.id)
          this.addLikeUser(this.loggedInUser)
        })
        .catch((e) => {
          const message = [e.response.data.message]
          this.setMessages({ messages: message, type: 'error' })
        })
    },
    async unlike () {
      await this.$axios.delete(`/likes/${this.post.id}`)
        .then(() => {
          this.$emit('change-to-liked', this.post.id)
          this.removeLoggedInUserLikedPost(this.post.id)
          this.removeLikeUser(this.loggedInUser)
        })
        .catch((e) => {
          const message = [e.response.data.message]
          this.setMessages({ messages: message, type: 'error' })
        })
    },
  },
}
</script>
