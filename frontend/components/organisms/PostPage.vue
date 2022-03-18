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
export default {
  props: {
    liked: {
      type: Boolean,
      required: true,
      default: false,
    },
    disliked: {
      type: Boolean,
      required: true,
      default: false,
    },
    post: {
      type: Object,
      required :true,
    },
    loggedInUser: {
      type: Object,
      required: true,
    },
    iconSize: {
      type: Number,
      required: true,
    },
    myPost: {
      type: Boolean,
      required: true,
      default: false,
    },
    favoriteRateGroup: {
      type: Array,
      required: true,
    },
  },
  methods: {
    changeToLiked () {
      this.$emit('change-to-liked')
    },
    changeToDisliked () {
      this.$emit('change-to-disliked')
    },
  },
}
</script>
