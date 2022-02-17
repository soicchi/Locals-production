<template>
  <p class="text-center main-title">
    {{ title }}
  </p>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      required: true,
    },
  },
}
</script>

<style lang="sass" scoped>
  .main-title
    font-size: 30px
</style>
