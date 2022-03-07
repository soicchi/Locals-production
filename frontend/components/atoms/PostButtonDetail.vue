<template>
  <div>
    <v-btn
      v-if="!$vuetify.breakpoint.xs"
      :to="`/posts/${postId}`"
      rounded
      elevation="1"
      color="mainColor detail-btn"
    >
      もっと見る
    </v-btn>
    <v-btn
      v-else
      :to="`/posts/${postId}`"
      rounded
      elevation="1"
      color="mainColor detail-btn"
      large
    >
      もっと見る
    </v-btn>
  </div>
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
