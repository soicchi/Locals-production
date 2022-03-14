<template>
  <OrganismsSignIn
    :is-valid.sync="isValid"
    :loading="loading"
    :user="user"
    :card-width="cardWidth"
    @sign-in="signIn"
    @guest-sign-in="guestSignIn"
  />
</template>

<script>
import { mapActions } from 'vuex'

export default {
  data: () => ({
    isValid: false,
    loading: false,
    user: {
      email: '',
      password: '',
    },
  }),
  computed: {
    cardWidth () {
      return this.$vuetify.breakpoint.xs ? '90%' : '25%'
    },
  },
  methods: {
    ...mapActions({
      setLoggedInUser: 'user/setLoggedInUser',
      setMessages: 'message/setMessages',
    }),
    async signIn () {
      this.loading = true
      setTimeout(() => {
        this.loading = false
      }, 3000)
      await this.$auth.loginWith('local', { data: this.user })
        .then((res) => {
          this.setLoggedInUser(res.data.data)
          const message = ['ログインしました']
          this.setMessages({ messages: message, type: 'success' })
        })
        .catch((e) => {
          const messages = e.response.data.errors
          this.setMessages({ messages, type: 'error' })
        })
    },
    async guestSignIn () {
      this.loading = true
      setTimeout(() => {
        this.loading = false
      }, 3000)
      await this.$axios.post('/guests')
        .then((res) => {
          this.$auth.loginWith('local', { data: res.data })
            .then((res) => {
              this.setLoggedInUser(res.data.data)
              const message = ['ログインしました']
              this.setMessages({ messages: message, type: 'success' })
            })
        })
    },
  },
}
</script>
