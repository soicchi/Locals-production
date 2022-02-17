<template>
  <OrganismsFollowAndFollowerPage
    :user='user'
    :logged-in-user='loggedInUser'
  />
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true
    },
    loggedInUser: {
      type: Object,
      required: true
    }
  },
  created() {
    const userId = this.$route.params.id
    this.$store.dispatch('user/getUser', userId)
  }
}
</script>