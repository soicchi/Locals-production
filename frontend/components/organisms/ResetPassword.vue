<template>
  <MoleculesFormCard :is-valid.sync="isValid">
    <template #form-title>
      <AtomsFormTitle :title="title" />
    </template>
    <template #form-card-content>
      <AtomsFormPassword :password.sync="password" />
      <AtomsFormPasswordConfirmation :password-confirmation.sync="passwordConfirmation" />
    </template>
    <template #form-card-button>
      <AtomsFormButtonUpdatePassword
        :is-valid="isValid"
        @update="update"
      />
    </template>
  </MoleculesFormCard>
</template>

<script>
export default {
  data () {
    return {
      password: '',
      passwordConfirmation: '',
      isValid: false,
    }
  },
  computed: {
    title: () => 'パスワード再設定',
  },
  methods: {
    async update () {
      const resetPasswordToken = this.$route.query.reset_password_token
      const headers = {
        'access-token': resetPasswordToken,
        uid: window.localStorage.getItem('uid'),
        client: window.localStorage.getItem('client'),
      }
      await this.$axios.put('/auth/password', { password: this.password, password_confirmation: this.passwordConfirmation }, { headers })
        .then(() => {
          this.$router.replace('/auth/signin')
          const message = 'パスワードを再設定しました'
          this.$store.dispatch('message/setMessages', { messages: message, type: 'success' })
        })
    },
  },
}
</script>
