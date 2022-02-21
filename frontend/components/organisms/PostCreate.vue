<template>
  <MoleculesFormCard :is-valid.sync="isValid">
    <template #form-title>
      <AtomsFormTitle :title="title" />
    </template>
    <template #form-card-content>
      <AtomsFormRestaurantName :restaurant-name.sync="post.restaurant_name" />
      <AtomsFormStation :station.sync="post.station" />
      <AtomsFormCategory
        :category-ids.sync="post.category_ids"
        :category-items="categoryItems"
      />
      <AtomsFormImage :images.sync="post.images" />
      <AtomsFormComment :comment.sync="post.comment" />
    </template>
    <template #form-card-button>
      <AtomsFormButtonCreatePost
        :is-valid="isValid"
        @create-post="createPost"
      />
    </template>
  </MoleculesFormCard>
</template>

<script>
export default {
  data () {
    return {
      post: {
        restaurant_name: '',
        comment: '',
        station: '',
        images: [],
        category_ids: [],
      },
      isValid: false,
    }
  },
  computed: {
    title () {
      return '投稿作成'
    },
    categoryItems () {
      return this.$store.getters['category/categories']
    },
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
