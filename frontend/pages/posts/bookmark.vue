<template>
  <TemplatesBookMarkPage
    :title="title"
    :icon-size="iconSize"
    :book-mark-posts="bookMarkPosts"
    :logged-in-user="loggedInUser"
    :post-card-width="postCardWidth"
  />
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      bookMarkPosts: 'bookMark/bookMarks',
      loggedInUser: 'user/loggedInUser',
    }),
    postCardWidth () {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs': return '100%'
        case 'sm': return '80%'
        case 'md': return '80%'
      }
      return '45%'
    },
    title: () => 'ブックマーク',
    iconSize: () => 48,
  },
  created () {
    this.$store.dispatch('bookMark/getBookMarks')
  },
}
</script>
