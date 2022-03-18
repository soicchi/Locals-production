<template>
  <OrganismsUserEdit
    :user.sync="user"
    :logged-in-user="loggedInUser"
    :title="title"
    :disabled="disabled"
    :card-width="cardWidth"
    @update="update"
    @delete-user="deleteUser"
  />
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data: () => ({
    user: {
      email: '',
      introduction: '',
      avatar: '',
    },
  }),
  computed: {
    ...mapGetters({
      loggedInUser: 'user/loggedInUser',
    }),
    disabled () {
      return this.user.avatar || this.user.email || this.user.introduction
    },
    cardWidth () {
      return this.$vuetify.breakpoint.xs ? '90%' : '25%'
    },
  },
  methods: {
    async update () {
      const confirm = window.confirm('更新を確定しますか')
      if (confirm) {
        const formData = new FormData()
        const headers = { 'Content-Type': 'multipart/form-data' }
        for (const [key, value] of Object.entries(this.user)) {
          if (value) {
            formData.append(`${key}`, value)
          }
        }
        await this.$axios.put('/auth', formData, headers)
          .then((res) => {
            this.$store.dispatch('user/getLoggedInUser')
            const message = ['更新が成功しました']
            this.$store.dispatch('message/setMessages', ({ messages: message, type: 'success' }))
            this.$router.replace(`/users/${this.loggedInUser.id}`)
          })
      }
    },
    async deleteUser () {
      const confirm = window.confirm('本当に退会してよろしいですか')
      if (confirm) {
        await this.$axios.delete('/auth')
        await this.$auth.logout()
          .then((res) => {
            localStorage.removeItem('access-token')
            localStorage.removeItem('token-type')
            localStorage.removeItem('uid')
            localStorage.removeItem('client')
            this.$store.dispatch('user/resetLoggedInUser')
            this.$router.replace('/auth/signup')
            this.$store.dispatch('message/setMessages', { messages: ['退会しました'], type: 'success' })
          })
      }
    },
  },
}
</script>
