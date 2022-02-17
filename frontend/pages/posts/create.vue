<template>
  <OrganismsPostCreate />
</template>

<script>
export default {
  created () {
    this.$store.dispatch('category/getCategories')
  },
}
</script>
