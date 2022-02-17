<template>
  <h1 class="form-title">
    {{ title }}
  </h1>
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
  .form-title
    @include commonTitle
</style>
