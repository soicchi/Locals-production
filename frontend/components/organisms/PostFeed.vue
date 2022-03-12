<template>
  <div>
    <MoleculesPostCard
      v-for="post in posts"
      :key="post.id"
      :post="post"
      :icon-size="iconSize"
      :logged-in-user="loggedInUser"
      :post-card-width="postCardWidth"
      @destroy-post="destroyPost"
    />
  </div>
</template>

<script>
export default {
  props: {
    posts: {
      type: Array,
      required: true,
    },
    loggedInUser: {
      type: Object,
      required: true,
    },
    iconSize: {
      type: Number,
      required: true,
    },
    postCardWidth: {
      type: String,
      required: true,
    },
  },
  methods: {
    destroyPost (post) {
      this.$emit('destroy-post', post)
    }
  },
}
</script>
