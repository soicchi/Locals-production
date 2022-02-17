<template>
  <div>
    <v-col
      v-if='!$auth.loggedIn || matchPath'
      cols='12'
      class='my-5' 
    >
      <OrganismsPostSearch />
    </v-col>
    <v-col
      cols='12'
      class='mt-5'
    >
      <AtomsCommonTitle :title='title' />
    </v-col>
    <OrganismsPostFeed :posts='posts' />
  </div>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      required: true
    },
    posts: {
      type: Array,
      required: true
    }
  },
  computed: {
    matchPath() {
      return this.$route.path === '/posts/all'
    }
  }
}
</script>