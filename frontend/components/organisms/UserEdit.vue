<template>
  <MoleculesFormCard>
    <template #form-title>
      <AtomsFormTitle :title="title" />
    </template>
    <template #form-card-content>
      <AtomsFormAvatar :avatar.sync="user.avatar" />
      <AtomsFormEmail :email.sync="user.email" />
      <AtomsFormIntroduction :introduction.sync="user.introduction" />
    </template>
    <template #form-card-button>
      <AtomsFormButtonUpdateUser
        :disabled="!disabled"
        @update="update"
      />
      <AtomsFormButtonDeleteUser @delete-user="deleteUser" />
    </template>
  </MoleculesFormCard>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  data () {
    return {
      user: {
        email: '',
        introduction: '',
        avatar: null,
      },
    }
  },
  computed: {
    ...mapGetters({
      loggedInUser: 'user/loggedInUser',
    }),
    title () {
      return 'プロフィール編集'
    },
    disabled () {
      return this.user.avatar || this.user.email || this.user.introduction
    },
  },
  methods: {
    ...mapActions({
      setLoggedInUser: 'user/setLoggedInUser',
      setMessages: 'message/setMessages',
    }),
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
            this.setLoggedInUser(res.data.data)
            const message = ['更新が成功しました']
            this.setMessages({ messages: message, type: 'success' })
            this.$router.replace(`/users/${this.loggedInUser.id}`)
          })
      }
    },
    async deleteUser () {
      const confirm = window.confirm('本当に退会してよろしいですか')
      if (confirm) {
        await this.$axios.delete('/auth')
        await this.$auth.logout()
          .then(() => {
            this.$store.dispatch('user/resetLoggedInUser')
            localStorage.remove('access-token')
            localStorage.remove('token-type')
            localStorage.remove('uid')
            localStorage.remove('client')
            this.$router.replace('/auth/signup')
          })
      }
    },
  },
}
</script>
