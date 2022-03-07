<template>
  <div>
    <v-col
      cols="12"
      class="my-5"
    >
      <AtomsCommonTitle :title="title" />
    </v-col>
    <OrganismsPostFeed :posts="likedPosts" />
  </div>
</template>

<script>
export default {
  computed: {
    title: () => 'また行きたいリスト',
    likedPosts () {
      return this.$store.getters['post/likedPosts']
    },
  },
  created () {
    const userId = this.$route.params.id
    this.$store.dispatch('post/getLikedPosts', userId)
  },
}
</script>
