<template>
  <div>
    <v-btn
      v-if="!bookMarked"
      icon
      :loading="loading"
      :disabled="loading"
      @click="bookMark"
    >
      <v-img
        height="40px"
        width="40px"
        src="/images/unsaved.png"
        alt="投稿を保存するボタン"
      />
    </v-btn>
    <v-btn
      v-else
      icon
      :loading="loading"
      :disabled="loading"
      @click="removeBookMark"
    >
      <v-img
        height="40px"
        width="40px"
        src="/images/saved.png"
        alt="投稿の保存を解除するボタン"
      />
    </v-btn>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  props: {
    loggedInUser: {
      type: Object,
      required: true,
    },
    post: {
      type: Object,
      required: true,
    },
  },
  data () {
    return {
      loading: false,
      bookMarked: false,
    }
  },
  computed: {
    myPage () {
      return this.$route.path === `/users/${this.loggedInUser.id}`
    },
  },
  created () {
    if (this.$auth.loggedIn && this.myPage) {
      this.loading = true
      setTimeout(() => {
        const bookMarkedState = this.loggedInUser.bookMarks.some((bookMark) => {
          return bookMark.id === this.post.id
        })
        if (bookMarkedState) {
          this.bookMarked = true
        }
        this.loading = false
      }, 1500)
    }
  },
  methods: {
    ...mapActions({
      addLoggedInUserBookMark: 'user/addLoggedInUserBookMark',
      removeLoggedInUserBookMark: 'user/removeLoggedInUserBookMark',
      setMessages: 'message/setMessages',
    }),
    async bookMark () {
      await this.$axios.post('/book_marks', { post_id: this.post.id })
        .then((res) => {
          this.bookMarked = true
          this.addLoggedInUserBookMark(this.post)
          const message = [res.data.message]
          this.setMessages({ messages: message, type: 'success' })
        })
    },
    async removeBookMark () {
      await this.$axios.delete(`/book_marks/${this.post.id}`)
        .then((res) => {
          this.bookMarked = false
          this.removeLoggedInUserBookMark(this.post)
          const message = [res.data.message]
          this.setMessages({ messages: message, type: 'success' })
        })
    },
  },
}
</script>
