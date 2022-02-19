<template>
  <p class="shop-name">
    {{ post.restaurant_name }}<span>/最寄り駅：{{ post.station }}</span>
  </p>
</template>

<script>
export default {
  props: {
    post: {
      type: Object,
      required: true,
    },
  },
}
</script>

<style lang="sass" scoped>
  .shop-name
    font-size: 34px
    span
      font-size: 18px
</style>
