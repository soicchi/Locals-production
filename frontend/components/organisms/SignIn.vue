<template>
  <MoleculesFormCard :is-valid.sync="isValid">
    <template #form-title>
      <AtomsFormTitle :title="title" />
    </template>
    <template #form-card-content>
      <AtomsFormEmail :email.sync="user.email" />
      <AtomsFormPassword :password.sync="user.password" />
      <!-- <div class='password-forget pl-8 mb-2'>
        パスワードを忘れた場合は
        <span>
          <v-btn
            text
            plain
            small
            to='/password/email'
            color='fontColor'
            class='pa-0 pr-4 pb-1 text-decoration-underline'
          >
            こちら
          </v-btn>
        </span>
      </div> -->
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
          this.$router.replace('/')
        })
        .catch((e) => {
          const messages = e.response.data.errors
          this.setMessages({ messages, type: 'error' })
        })
    },
  },
}
</script>

<style lang="sass" scoped>
  .password-forget
    font-size: 12px
</style>
