<template>
  <MoleculesPostSort
    :sort-list="sortList"
    :sort-val.sync="sortVal"
  />
</template>

<script>
export default {
  data: () => ({
    sortVal: '',
  }),
  computed: {
    sortList () {
      return ['最新順', 'また行きたい順（高）']
    },
  },
  created () {
    this.sortVal = '最新順'
  },
  watch: {
    sortVal () {
      if (this.sortVal === '最新順') {
        this.$store.dispatch('post/newSort')
      } else if (this.sortVal === 'また行きたい順（高）') {
        this.$store.dispatch('post/likeSort')
      }
    }
  }
}
</script>