<template>
  <TemplatesAdminPage
    :posts="posts"
    :categories="categories"
    :category.sync="category"
    :icon-size="iconSize"
    :title="title"
    @add-category="addCategory"
    @destroy-post="destroyPost"
    @remove-category="removeCategory"
  />
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  data: () => ({
    category: '',
    // sortVal: '',
  }),
  computed: {
    ...mapGetters({
      posts: 'post/posts',
      categories: 'category/categories',
    }),
    iconSize: () => 60,
    title: () => '管理画面',
    // sortList () {
    //   return [
    //     '今日',
    //     '前日',
    //     '1週間',
    //   ]
    // },
    confirm () {
      return window.confirm('本当に削除しますか')
    },
  },
  created () {
    this.$store.dispatch('category/getCategories')
    this.$store.dispatch('post/getPosts')
    // this.sortVal = '今日'
  },
  // watch: {
  //   sortVal () {
  //     if (this.sortVal === '今日') {
  //       this.$store.dispatch('post/todaySort')
  //     }
  //   }
  // },
  methods: {
    ...mapActions({
      setCategories: 'category/setCategories',
      setMessages: 'message/setMessages',
      removePost: 'post/removePost',
    }),
    addCategory () {
      this.$axios.post('/categories', { name: this.category })
        .then((res) => {
          this.setCategories(res.data)
          const messages = ['カテゴリーを追加しました']
          this.setMessages({ messages, type: 'success' })
        })
        .catch((e) => {
          const messages = e.response.data
          this.setMessages({ messages, type: 'error' })
        })
    },
    async destroyPost (post) {
      if (this.confirm) {
        await this.$axios.delete(`/posts/${post.id}`)
          .then((res) => {
            this.removePost(post)
            const message = [res.data.message]
            this.setMessages({ messages: message, type: 'success' })
          })
      }
    },
    async destroyUser (userId) {
      if (this.confirm) {
        await this.$axios.delete(`/users/${userId}`)
          .then((res) => {
            const message = ['ユーザが削除されました']
            this.setMessages({ messages: message, type: 'success' })
            this.$store.dispatch('post/getPosts')
          })
      }
    },
    async removeCategory (categoryId) {
      if (this.confirm) {
        await this.$axios.delete(`/categories/${categoryId}`)
          .then((res) => {
            this.$store.dispatch('category/removeCategory', categoryId)
          })
      }
    },
  },
}
</script>
