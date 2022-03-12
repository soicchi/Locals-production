<template>
  <MoleculesFormCard :is-valid.sync="setIsValid">
    <template #form-title>
      <AtomsFormTitle :title="pageTitle" />
    </template>
    <template #form-card-content>
      <AtomsFormName :name.sync="setUser.name" />
      <AtomsFormEmail
        :email.sync="setUser.email"
        :no-validation="noValidation"
      />
      <AtomsFormBirthPlace :birth-place.sync="setUser.birth_place" />
      <AtomsFormBirthDay
        :birth-year.sync="setUser.birth_year"
        :birth-month.sync="setUser.birth_month"
        :birth-day.sync="setUser.birth_day"
        @reset-day="resetDay"
      />
      <AtomsFormPassword
        :password.sync="setUser.password"
        :no-validation="noValidation"
      />
      <AtomsFormPasswordConfirmation :password-confirmation.sync="setUser.password_confirmation" />
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
export default {
  props: {
    user: {
      type: Object,
      requried: true,
    },
    noValidation: {
      type: Boolean,
      required: true,
      default: false,
    },
    isValid: {
      type: Boolean,
      required: true,
      default: false,
    },
    loading: {
      type: Boolean,
      required: true,
      default: false,
    },
    pageTitle: {
      type: String,
      required: true,
    },
  },
  computed: {
    setUser: {
      get () { return this.user },
      set (newVal) { return this.$emit('update:user', newVal) },
    },
    setIsValid: {
      get () { return this.isValid },
      set (newVal) { return this.$emit('update:isValid', newVal) },
    },
  },
  methods: {
    signUp () {
      this.$emit('sign-up')
    },
    resetDay () {
      this.$emit('reset-day')
    },
  },
}
</script>
