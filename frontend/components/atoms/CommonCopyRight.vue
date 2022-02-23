<template>
  <div class="locals">
    <strong>&copy;{{ copyRightYear }} Local's</strong>
  </div>
</template>

<script>
export default {
  computed: {
    copyRightYear () {
      const beginningYear = 2021
      const thisYear = new Date().getFullYear()
      return (beginningYear < thisYear) ? `${beginningYear} - ${thisYear}` : beginningYear
    },
  },
}
</script>

<style lang="sass" scoped>
  .locals
    color: #fff
</style>
