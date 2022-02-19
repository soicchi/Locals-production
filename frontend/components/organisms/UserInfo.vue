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
      followingCount: 'relationShip/followingCount',
      followersCount: 'relationShip/followersCount',
      likedPostsCount: 'like/likedPostsCount',
    }),
  },
}
</script>
