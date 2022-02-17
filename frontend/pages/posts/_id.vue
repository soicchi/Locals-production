<template>
  <OrganismsPostPage />
</template>

<script>
export default {
  async asyncData({ params, $axios, store }) {
    await $axios.get(`/posts/${params.id}`)
    .then(res => {
      store.commit('post/setPost', res.data)
    })
  }
}
</script>