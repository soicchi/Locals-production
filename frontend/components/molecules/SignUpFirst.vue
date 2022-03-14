<template>
  <MoleculesFormCard
    :is-valid.sync="setIsValid"
    :card-width="cardWidth"
  >
    <template #form-title>
      <h2>新規アカウント</h2>
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
      <v-btn
        :disabled="!isValid"
        text
        plain
        @click="next"
      >
        次へ
      </v-btn>
    </template>
  </MoleculesFormCard>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      requried: true,
      default: null,
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
    subPage: {
      type: Object,
      required: true,
    },
    cardWidth: {
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
    resetDay () {
      this.$emit('reset-day')
    },
    next () {
      this.$emit('next')
    },
  },
}
</script>
