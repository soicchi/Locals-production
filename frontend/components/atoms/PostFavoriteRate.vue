<template>
  <div>
    <p class="percent-font mb-0">
      また行きたい！
    </p>
    <div>
      <v-icon
        :size="iconSize"
        color="mainColor"
      >
        mdi-account
      </v-icon>
      <span class="percentage">
        {{ percentage }}<span>%</span>
      </span>
    </div>
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
    iconSize () {
      return this.$vuetify.breakpoint.xs ? '50' : '70'
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
