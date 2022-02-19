<template>
  <v-btn
    text
    plain
    :to="`/users/${userId}/liked_posts`"
  >
    Like : {{ likedPostsCount }}
  </v-btn>
</template>

<script>
export default {
  props: {
    likedPostsCount: {
      type: Number,
      required: true,
    },
  },
  computed: {
    userId () {
      return this.$route.params.id
    },
  },
}
</script>
