<template>
  <v-btn
    :to="`/posts/${postId}`"
    rounded
    elevation="1"
    color="mainColor detail-btn"
  >
    もっと見る
  </v-btn>
</template>

<script>
export default {
  props: {
    postId: {
      type: Number,
      required: true,
    },
  },
}
</script>

<style lang="sass" scoped>
  .detail-btn
    @include commonBtn
</style>
