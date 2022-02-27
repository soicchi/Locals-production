<template>
  <MoleculesUserInfo
    :user="user"
    :logged-in-user="loggedInUser"
    :following-count="followingCount"
    :followers-count="followersCount"
    :liked-posts-count="likedPostsCount"
    :icon-size="iconSize"
  />
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    iconSize () {
      return 100
    },
    ...mapGetters({
      user: 'user/user',
      loggedInUser: 'user/loggedInUser',
      followingCount: 'user/followingCount',
      followersCount: 'user/followersCount',
      likedPostsCount: 'user/likedPostsCount',
    }),
  },
}
</script>
