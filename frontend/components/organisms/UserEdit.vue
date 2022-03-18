<template>
  <MoleculesFormCard :card-width="cardWidth">
    <template #form-title>
      <h2>プロフィール編集</h2>
    </template>
    <template #form-card-content>
      <AtomsFormAvatar :avatar.sync="setUser.avatar" />
      <AtomsFormEmail :email.sync="setUser.email" />
      <AtomsFormIntroduction :introduction.sync="setUser.introduction" />
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
export default {
  props: {
    user: {
      type: Object,
      required: true,
    },
    loggedInUser: {
      type: Object,
      required: true,
    },
    disabled: {
      type: Boolean,
      required: true,
      default: false,
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
  },
  methods: {
    update () {
      this.$emit('update')
    },
    deleteUser () {
      this.$emit('delete-user')
    },
  },
}
</script>
