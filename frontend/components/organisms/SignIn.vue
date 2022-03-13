<template>
  <MoleculesFormCard
    :is-valid.sync="isValid"
    :card-width="cardWidth"
    p
  >
    <template #form-title>
      <AtomsFormTitle :title="title" />
    </template>
    <template #form-card-content>
      <AtomsFormEmail :email.sync="user.email" />
      <AtomsFormPassword :password.sync="user.password" />
      <v-row
        justify="center"
        class="my-1"
      >
        <v-btn
          text
          plain
          color="fontColor"
          class="text-decoration-underline"
          @click="guestSignIn"
        >
          ゲストとしてログイン
        </v-btn>
      </v-row>
    </template>
    <template #form-card-button>
      <AtomsFormButtonSignIn
        :loading="loading"
        :is-valid="isValid"
        @sign-in="signIn"
      />
    </template>
  </MoleculesFormCard>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  data () {
    return {
      isValid: false,
      loading: false,
      user: {
        email: '',
        password: '',
      },
    }
  },
  computed: {
    title () {
      return 'ログイン'
    },
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

<style lang="sass" scoped>
  .password-forget
    font-size: 12px
</style>
