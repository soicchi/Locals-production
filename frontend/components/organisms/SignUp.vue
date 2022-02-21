<template>
  <MoleculesFormCard :is-valid.sync="isValid">
    <template #form-title>
      <AtomsFormTitle :title="title" />
    </template>
    <template #form-card-content>
      <AtomsFormName :name.sync="user.name" />
      <AtomsFormEmail
        :email.sync="user.email"
        :no-validation="noValidation"
      />
      <AtomsFormBirthPlace :birth-place.sync="user.birth_place" />
      <AtomsFormBirthDay
        :birth-year.sync="user.birth_year"
        :birth-month.sync="user.birth_month"
        :birth-day.sync="user.birth_day"
        @reset-day="resetDay"
      />
      <AtomsFormGender :gender.sync="user.gender" />
      <AtomsFormPassword
        :password.sync="user.password"
        :no-validation="noValidation"
      />
      <AtomsFormPasswordConfirmation :password-confirmation.sync="user.password_confirmation" />
    </template>
    <template #form-card-button>
      <AtomsFormButtonSignUp
        :loading="loading"
        :is-valid="isValid"
        @sign-up="signUp"
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
        name: '',
        email: '',
        birth_place: '',
        birth_year: 0,
        birth_month: 0,
        birth_day: 0,
        gender: '',
        password: '',
        password_confirmation: '',
      },
      noValidation: false,
      isValid: false,
      loading: false,
    }
  },
  computed: {
    title: () => '新規アカウント作成',
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
      }, 3000)
      await this.$axios.post('/auth', this.user)
        .then(() => {
          this.$auth.loginWith('local', { data: { email: this.user.email, password: this.user.password } })
            .then((res) => {
              this.setLoggedInUser(res.data.data)
              this.$router.replace('/')
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
  },
}
</script>
