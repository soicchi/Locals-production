<template>
  <MoleculesFormCard :is-valid.sync="isValid">
    <template #form-title>
      <AtomsFormTitle :title="title" />
    </template>
    <template #form-card-content>
      <AtomsFormEmail :email.sync="email" />
    </template>
    <template #form-card-button>
      <AtomsFormButtonSendEmail
        :is-valid="isValid"
        :loading="loading"
        @send-email="sendEmail"
      />
    </template>
  </MoleculesFormCard>
</template>

<script>
export default {
  data () {
    return {
      email: '',
      loading: false,
      isValid: false,
    }
  },
  computed: {
    title: () => 'パスワード再設定用Email入力フォーム',
    redirectUrl () {
      return process.env.NODE_ENV === 'production' ? 'https://locals-apps.com/users/password/edit' : 'http://localhost:3000/users/password/edit'
    },
  },
  methods: {
    async sendEmail () {
      this.loading = true
      setTimeout(() => {
        this.loading = false
      }, 1500)
      await this.$axios.post('/auth/password', { email: this.email, redirect_url: this.redirectUrl })
        .then((res) => {
          const message = [res.data.message]
          this.$store.dispatch('message/setMessages', { messages: message, type: 'success' })
        })
        .catch((e) => {
          const message = e.response.data.errors
          this.$store.dispatch('message/setMessages', { messages: message, type: 'error' })
        })
    },
  },
}
</script>
