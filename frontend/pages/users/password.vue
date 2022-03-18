<template>
  <OrganismsEditPassword
    :user.sync="user"
    :no-validation="noValidation"
    :is-valid.sync="isValid"
    :logged-in-user="loggedInUser"
    :card-width="cardWidth"
    :loading="loading"
    @update="update"
  />
</template>

<script>
export default {
  data: () => ({
    user: {
      password: '',
      password_confirmation: '',
    },
    noValidation: false,
    isValid: false,
    loading: false,
  }),
  computed: {
    loggedInUser () {
      return this.$store.getters['user/loggedInUser']
    },
    cardWidth () {
      return this.$vuetify.breakpoint.xs ? '90%' : '25%'
    },
  },
  methods: {
    async update () {
      this.loading = true
      setTimeout(() => {
        this.loading = false
      }, 5000)
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
