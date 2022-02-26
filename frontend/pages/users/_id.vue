<template>
  <div>
    <TemplatesUserPage
      v-if="matchName"
      :posts="user.posts"
    />
    <NuxtChild
      :user="user"
      :logged-in-user="loggedInUser"
    />
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      loggedInUser: 'user/loggedInUser',
      user: 'user/user',
    }),
    matchName () {
      return this.$route.path === `/users/${this.user.id}`
    },
  },
  created () {
    const userId = this.$route.params.id
    this.getUser(userId)
    if (this.$auth.loggedIn) {
      this.setLoggedInUserFollowing(this.loggedInUser.id)
    }
  },
  methods: {
    ...mapActions({
      getUser: 'user/getUser',
      setLoggedInUserFollowing: 'user/setLoggedInUserFollowing',
    }),
  },
}
</script>
