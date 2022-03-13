<template>
  <OrganismsSignUp
    :user.sync="user"
    :no-validation="noValidation"
    :is-valid.sync="isValid"
    :loading="loading"
    :sub-page="subPage"
    :preference-list="preferenceList"
    :transition-name="transitionName"
    :card-width="cardWidth"
    @sign-up="signUp"
    @reset-day="resetDay"
    @next="next"
    @back="back"
  />
</template>

<script>
import { mapActions } from 'vuex'
import SignUpFirst from '~/components/molecules/SignUpFirst'
import SignUpSecond from '~/components/molecules/SignUpSecond'
import SignUpConfirm from '~/components/molecules/SignUpConfirm'

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
      tasteIds: [],
    },
    noValidation: false,
    isValid: false,
    loading: false,
    transitionName: '',
  }),
  computed: {
    subPage () {
      switch (this.$route.hash) {
        case '#second':
          return SignUpSecond
        case '#confirm':
          return SignUpConfirm
        default:
          return SignUpFirst
      }
    },
    preferenceList () {
      // return this.$store.getters['preference/preferenceList']
      return [
        { id: 1, content: '価格' },
        { id: 2, content: '雰囲気' },
        { id: 3, content: '場所' },
        { id: 4, content: '接客' },
        { id: 5, content: '味' },
      ]
    },
    cardWidth () {
      return this.$vuetify.breakpoint.xs ? '90%' : '25%'
    },
  },
  created () {
    this.$router.push('/auth/signup')
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
    next () {
      this.transitionName = 'slide-next'
      switch (this.$route.hash) {
        case '#second':
          this.$router.push({ hash: '#confirm' })
          break
        default:
          this.$router.push({ hash: '#second' })
          break
      }
    },
    back () {
      this.transitionName = 'slide-back'
      switch (this.$route.hash) {
        case '#second':
          this.$router.push('/auth/signup')
          break
        case '#confirm':
          this.$router.push({ hash: '#second' })
          break
      }
    },
  },
}
</script>
