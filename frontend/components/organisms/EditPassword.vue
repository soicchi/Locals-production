<template>
  <MoleculesFormCard
    :is-valid.sync="setIsValid"
    :card-width="cardWidth"
  >
    <template #form-title>
      <h2>パスワード変更</h2>
    </template>
    <template #form-card-content>
      <AtomsFormPassword
        :password.sync="setUser.password"
        :no-validation="noValidation"
      />
      <AtomsFormPasswordConfirmation :password-confirmation.sync="setUser.password_confirmation" />
    </template>
    <template #form-card-button>
      <AtomsFormButtonUpdatePassword
        :is-valid="isValid"
        :loading="loading"
        @update="update"
      />
    </template>
  </MoleculesFormCard>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true,
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
    loggedInUser: {
      type: Object,
      required: true,
    },
    cardWidth: {
      type: String,
      required: true,
    },
    loading: {
      type: Boolean,
      required: true,
      default: false,
    },
  },
  computed: {
    setUser: {
      get () { return this.user },
      set (newVal) { return this.$emit('update:user', newVal) },
    },
    setIsValid: {
      get () { return this.isValid },
      set (newVal) { return this.$emit('update:isValid', newVal) }
    }
  },
  methods: {
    update () {
      this.$emit('update')
    },
  },
}
</script>
