<template>
  <div>
    <p class="percent-font mb-0">
      また行きたい！
    </p>
    <div class="d-flex">
      <v-icon
        :size="iconSize"
        color="mainColor"
      >
        mdi-account
      </v-icon>
      <div class="percentage">
        {{ post.like_percentage }}<span>%</span>
      </div>
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
