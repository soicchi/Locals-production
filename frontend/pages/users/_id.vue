<template>
  <div>
    <TemplatesUserPage
      v-if='matchName'
      :posts='posts'  
    />
    <NuxtChild
      :user='user'
      :logged-in-user='loggedInUser'
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex';
import { mapActions } from 'vuex';

export default {
  computed: {
    ...mapGetters({
      loggedInUser: 'user/loggedInUser',
      user: 'user/user',
      posts: 'post/posts'
    }),
    matchName() {
      return this.$route.path === `/users/${this.user.id}`
    }
  },
  created() {
    const userId = this.$route.params.id
    this.getUser(userId)
    this.getUserPosts(userId)
    this.setLoggedInUserFollowing(this.loggedInUser.id)
  },
  methods: {
    ...mapActions({
      getUser: 'user/getUser',
      getUserPosts: 'post/getUserPosts',
      setLoggedInUserFollowing: 'user/setLoggedInUserFollowing'
    })
  },
}
</script>