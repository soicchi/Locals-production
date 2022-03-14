<template>
  <MoleculesFormCard
    :is-valid.sync="isValid"
    :card-width="cardWidth"
  >
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
    cardWidth () {
      return this.$vuetify.breakpoint.xs ? '90%' : '25%'
    },
  },
  methods: {
    async update () {
      await this.$axios.put('/auth/password', this.user)
        .then((res) => {
          this.$store.dispatch('user/getLoggedInUser')
          const message = [res.data.message]
          this.$store.dispatch('message/setMessages', ({ messages: message, type: 'success' }))
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
