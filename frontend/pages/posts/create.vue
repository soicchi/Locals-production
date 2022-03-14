<template>
  <OrganismsPostCreate
    :post.sync="post"
    :is-valid.sync="isValid"
    :category-items="categoryItems"
    :card-width="cardWidth"
    :transition-name="transitionName"
    :evaluation-list="evaluationList"
    :sub-page="subPage"
    @create-post="createPost"
    @next="next"
    @back="back"
  />
</template>

<script>
import PostCreateFirst from '~/components/molecules/PostCreateFirst'
import PostCreateSecond from '~/components/molecules/PostCreateSecond'

export default {
  data: () => ({
    post: {
      restaurant_name: '',
      comment: '',
      station: '',
      images: [],
      category_ids: [],
      taste_ids: [],
    },
    isValid: false,
    transitionName: '',
  }),
  computed: {
    categoryItems () {
      return this.$store.getters['category/categories']
    },
    cardWidth () {
      return this.$vuetify.breakpoint.xs ? '90%' : '25%'
    },
    subPage () {
      switch (this.$route.hash) {
        case '#second':
          return PostCreateSecond
        default:
          return PostCreateFirst
      }
    },
    evaluationList () {
      return this.$store.getters['taste/tastes']
    },
  },
  created () {
    this.$store.dispatch('category/getCategories')
    this.$router.push('/posts/create')
    this.$store.dispatch('taste/getTastes')
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
    next () {
      this.transitionName = 'slide-next'
      this.$router.push({ hash: '#second' })
    },
    back () {
      this.transitionName = 'slide-back'
      this.$router.push('/posts/create')
    },
  },
}
</script>
