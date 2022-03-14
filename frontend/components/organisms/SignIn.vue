<template>
  <MoleculesFormCard
    :is-valid.sync="setIsValid"
    :card-width="cardWidth"
  >
    <template #form-title>
      <h2>ログイン</h2>
    </template>
    <template #form-card-content>
      <AtomsFormEmail :email.sync="setUser.email" />
      <AtomsFormPassword :password.sync="setUser.password" />
      <v-row
        justify="center"
        class="my-1"
      >
        <v-btn
          text
          plain
          color="fontColor"
          class="text-decoration-underline"
          :disabled="loading"
          :loading="loading"
          @click="guestSignIn"
        >
          ゲストとしてログイン
        </v-btn>
      </v-row>
    </template>
    <template #form-card-button>
      <AtomsFormButtonSignIn
        :loading="loading"
        :is-valid="isValid"
        @sign-in="signIn"
      />
    </template>
  </MoleculesFormCard>
</template>

<script>
export default {
  props: {
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
    user: {
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
    signIn () {
      this.$emit('sign-in')
    },
    guestSignIn () {
      this.$emit('guest-sign-in')
    },
  },
}
</script>
