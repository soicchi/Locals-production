<template>
  <OrganismsPostCreate
    :post.sync="post"
    :is-valid.sync="isValid"
    :category-items="categoryItems"
    :card-width="cardWidth"
    @create-post="createPost"
  />
</template>

<script>
export default {
  data: () => ({
    post: {
      restaurant_name: '',
      comment: '',
      station: '',
      images: [],
      category_ids: [],
    },
    isValid: false,
  }),
  computed: {
    categoryItems () {
      return this.$store.getters['category/categories']
    },
    cardWidth () {
      return this.$vuetify.breakpoint.xs ? '90%' : '25%'
    },
  },
  created () {
    this.$store.dispatch('category/getCategories')
  },
  methods: {
    async createPost () {
      const headers = { 'Content-Type': 'multipart/form-data' }
      const formData = new FormData()
      formData.append('restaurant_name', this.post.restaurant_name)
      formData.append('comment', this.post.comment)
      formData.append('station', this.post.station)
      for (const categoryId of this.post.category_ids) {
        formData.append('category_ids[]', categoryId)
      }
      for (const image of this.post.images) {
        formData.append('images[]', image)
      }
      await this.$axios.post('/posts', formData, headers)
        .then((res) => {
          const message = [res.data.message]
          this.$store.dispatch('message/setMessages', { messages: message, type: 'success' })
          this.$router.replace('/')
        })
        .catch((e) => {
          const message = e.response.data
          this.$store.dispatch('message/setMessages', { messages: message, type: 'error' })
        })
    },
  },
}
</script>
