<template>
  <OrganismsSignUp
    :user.sync="user"
    :no-validation="noValidation"
    :is-valid.sync="isValid"
    :loading="loading"
    :page-title="pageTitle"
    @sign-up="signUp"
    @reset-day="resetDay"
  />
</template>

<script>
import { mapActions } from 'vuex'

export default {
  data: () => ({
    user: {
      name: '',
      email: '',
      birth_place: '',
      birth_year: 0,
      birth_month: 0,
      birth_day: 0,
      password: '',
      password_confirmation: '',
    },
    noValidation: false,
    isValid: false,
    loading: false,
  }),
  computed: {
    pageTitle: () => '新規アカウント',
  },
  methods: {
    ...mapActions({
      setLoggedInUser: 'user/setLoggedInUser',
      setMessages: 'message/setMessages',
    }),
    async signUp () {
      this.loading = true
      setTimeout(() => {
        this.loading = false
      }, 4000)
      await this.$axios.post('/auth', this.user)
        .then(() => {
          this.$auth.loginWith('local', { data: { email: this.user.email, password: this.user.password } })
            .then((res) => {
              this.setLoggedInUser(res.data.data)
              this.setMessages({ messages: ['ログインしました'], type: 'success' })
            })
        })
        .catch((e) => {
          const messages = e.response.data.errors.full_messages
          const type = e.response.data.status
          this.setMessages({ messages, type })
        })
    },
    resetDay () {
      this.day = ''
    },
  },
}
</script>
