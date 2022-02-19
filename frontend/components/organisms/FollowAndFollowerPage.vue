<template>
  <MoleculesFollowAndFollowerList
    :user="user"
    :logged-in-user="loggedInUser"
    :path-name="pathName"
    :icon-size="iconSize"
  />
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
  },
  computed: {
    pathName () {
      return this.$route.path === `/users/${this.user.id}/following`
    },
    iconSize () {
      return 60
    },
  },
}
</script>
