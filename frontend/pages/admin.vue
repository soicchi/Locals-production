<template>
  <TemplatesAdminPage
    :posts="posts"
    :categories="categories"
    :category.sync="category"
    :icon-size="iconSize"
    :sort-val="sortVal"
    :sort-list="sortList"
    @add-category="addCategory"
    @destroy-post="destroyPost"
  />
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  data: () => ({
    category: '',
    sortVal: '',
  }),
  computed: {
    ...mapGetters({
      posts: 'post/posts',
      categories: 'category/categories',
    }),
    iconSize: () => 60,
    sortList() {
      return [
        '今日',
        '1週間',
        '1ヶ月間',
      ]
    },
  },
  created () {
    this.$store.dispatch('category/getCategories')
    this.$store.dispatch('post/getPosts')
    this.sortVal = '今日'
  },
  // watch: {
  //   sortVal () {
  //     if (this.sortVal === '本日') {
        
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
          this.setMessages({ messages: messages, type: 'success' })
        })
    },
    async destroyPost (postId) {
      if (window.confirm('投稿を削除しますか')) {
        await this.$axios.delete(`/posts/${postId}`)
          .then((res) => {
            this.removePost(post)
            const message = [res.data.message]
            this.setMessages({ messages: message, type: 'success' })
          })
      }
    },
    async destroyUser (userId) {
      if (window.confirm('ユーザーを削除しますか')) {
        await this.$axios.delete(`/users/${userId}`)
          .then((res) => {
            const message = ['ユーザが削除されました']
            this.setMessages({ messages: message, type: 'success' })
            this.$store.dispatch('post/getPosts')
          })
      }
    }
  }
}
</script>