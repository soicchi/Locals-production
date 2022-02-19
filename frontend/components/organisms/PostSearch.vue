<template>
  <MoleculesPostSearch
    ref="modal"
    :loading="loading"
    :category-ids.sync="categoryIds"
    :category-items="categoryItems"
    :title="title"
    :is-valid.sync="isValid"
    @search="search"
    @reset="reset"
  />
</template>

<script>
import { mapActions } from 'vuex'

export default {
  data () {
    return {
      loading: false,
      isValid: false,
      categoryIds: [],
      title: 'カテゴリーで検索',
    }
  },
  computed: {
    categoryItems () {
      return this.$store.getters['category/categories']
    },
  },
  methods: {
    ...mapActions({
      setMessages: 'message/setMessages',
      setPosts: 'post/setPosts',
    }),
    async search () {
      await this.$axios.get('/search', { params: { category_ids: this.categoryIds } })
        .then((res) => {
          this.$refs.modal.dialog = false
          this.setPosts(res.data)
        })
        .catch((e) => {
          const message = [e.response.data.message]
          this.setMessages({ messages: message, type: 'error' })
        })
    },
    reset () {
      this.categoryIds = []
      this.$store.dispatch('post/getPosts')
    },
  },
}
</script>
