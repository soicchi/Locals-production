<template>
  <div>
    <p class="percent-font">
      また行きたい！
    </p>
    <v-icon size="70">
      mdi-account
    </v-icon>
    <span class="percentage">
      {{ percentage }}<span>%</span>
    </span>
  </div>
</template>

<script>
export default {
  props: {
    post: {
      type: Object,
      required: true,
    },
  },
  computed: {
    percentage () {
      const likesCount = Number(this.post.like_users.length)
      const dislikesCount = Number(this.post.dislike_users.length)
      const percent = likesCount / (likesCount + dislikesCount) * 100
      if (!percent) {
        return 0
      } else {
        return Math.round(percent)
      }
    },
  },
}
</script>

<style lang="sass">
  .percentage
    font-size: 40px
    span
      font-size: 20px
  .percent-font
    font-size: 12px
</style>
