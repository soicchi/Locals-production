<template>
  <MoleculesFormCard :is-valid.sync="isValid">
    <template #form-title>
      <AtomsFormTitle :title="title" />
    </template>
    <template #form-card-content>
      <AtomsFormPassword
        :password.sync="user.password"
        :no-validation="noValidation"
      />
      <AtomsFormPasswordConfirmation :password-confirmation.sync="user.password_confirmation" />
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
import { mapActions } from 'vuex'

export default {
  data () {
    return {
      user: {
        password: '',
        password_confirmation: '',
      },
      noValidation: false,
      isValid: false,
    }
  },
  computed: {
    title () {
      return 'パスワード変更'
    },
    loggedInUser () {
      return this.$store.getters['user/loggedInUser']
    },
  },
  methods: {
    ...mapActions({
      setLoggedInUser: 'user/setLoggedInUser',
      setMessages: 'message/setMessages',
    }),
    async update () {
      await this.$axios.put('/auth/password', this.user)
        .then((res) => {
          this.setLoggedInUser(res.data.data)
          const message = [res.data.message]
          this.setMessages({ messages: message, type: 'success' })
          this.$router.replace(`/users/${this.loggedInUser.id}`)
        })
        .catch((e) => {
          const message = e.response.data.errors.full_messages
          this.setMessages({ messages: message, type: 'error' })
        })
    },
  },
}
</script>
