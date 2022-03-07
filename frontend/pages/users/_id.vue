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
import { mapGetters } from 'vuex'

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
    this.$store.dispatch('user/getUser',userId)
  },
}
</script>
