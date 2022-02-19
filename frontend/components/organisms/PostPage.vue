<template>
  <MoleculesPostDetail
    :icon-size="iconSize"
    :post="post"
    :logged-in-user="loggedInUser"
    :liked="liked"
    :disliked="disliked"
    :my-post="myPost"
    :favorite-rate-group="favoriteRateGroup"
    @change-to-liked="changeToLiked"
    @change-to-disliked="changeToDisliked"
  />
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data () {
    return {
      liked: false,
      disliked: false,
    }
  },
  computed: {
    ...mapGetters({
      post: 'post/post',
      loggedInUser: 'user/loggedInUser',
    }),
    iconSize: () => 60,
    myPost () {
      return this.loggedInUser.id === this.post.user_id
    },
    favoriteRateGroup () {
      const favoriteRate = []
      const likedUserGroup = this.post.liked_age_group
      const dislikedUserGroup = this.post.disliked_age_group
      for (let i = 0; i < likedUserGroup.length; i++) {
        const percent = likedUserGroup[i] / (likedUserGroup[i] + dislikedUserGroup[i]) * 100
        if (percent <= 0) {
          favoriteRate.push(0)
        } else {
          favoriteRate.push(Math.round(percent))
        }
      }
      return favoriteRate
    },
  },
  methods: {
    changeToLiked (postId) {
      this.liked = !this.liked
      if (this.disliked) {
        this.disliked = false
        this.$store.dispatch('user/removeLoggedInUserDislikedPost', postId)
        this.$store.dispatch('post/removeDislikeUser', this.loggedInUser)
      }
    },
    changeToDisliked (postId) {
      this.disliked = !this.disliked
      if (this.liked) {
        this.liked = false
        this.$store.dispatch('user/removeLoggedInUserLikedPost', postId)
        this.$store.dispatch('post/removeLikeUser', this.loggedInUser)
      }
    },
  },
}
</script>
