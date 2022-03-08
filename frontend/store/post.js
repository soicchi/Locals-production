export const state = () => ({
  posts: [],
  post: {},
  likedPosts: [],
})

export const getters = {
  posts: state => state.posts,
  post: state => state.post,
  likedPosts: state => state.likedPosts,
}

export const mutations = {
  setPosts (state, postData) {
    state.posts = postData
  },
  setPost (state, postData) {
    state.post = postData
  },
  setLikedPosts (state, posts) {
    state.likedPosts = posts
  },
  removePost (state, postData) {
    state.posts = state.posts.filter((post) => {
      return post !== postData
    })
  },
  setBookMarkUsers (state, users) {
    state.post.bookMarkUsers = users
  },
  addLikeUser (state, user) {
    state.post.like_users.unshift(user)
  },
  removeLikeUser (state, user) {
    state.post.like_users = state.post.like_users.filter((likeUser) => {
      return likeUser.id !== user.id
    })
  },
  addDislikeUser (state, user) {
    state.post.dislike_users.unshift(user)
  },
  removeDislikeUser (state, user) {
    state.post.dislike_users = state.post.dislike_users.filter((dislikeUser) => {
      return dislikeUser.id !== user.id
    })
  },
  newSort (state) {
    state.posts.sort((a, b) => {
      if (a.created_at > b.created_at) return -1
      if (a.created_at < b.created_at) return 1
      return 0
    })
  },
  likeSort (state) {
    state.posts.sort((a, b) => {
      if (a.like_percentage > b.like_percentage) return -1
      if (a.like_percentage < b.like_percentage) return 1
      return 0
    })
  }
}

export const actions = {
  async getPosts ({ commit }) {
    await this.$axios.get('/posts')
      .then((res) => {
        commit('setPosts', res.data)
      })
  },
  async getPost ({ commit }, postId) {
    await this.$axios.get(`/posts/${postId}`)
      .then((res) => {
        commit('setPost', res.data)
      })
  },
  async getLikedPosts ({ commit }, userId) {
    await this.$axios.get('/users/liked_posts', { params: { id: userId } })
      .then((res) => {
        commit('setLikedPosts', res.data)
      })
  },
  async getFollowingPosts ({ commit }) {
    await this.$axios.get('/users/following_posts')
      .then((res) => {
        commit('setPosts', res.data)
      })
  },
  setPosts ({ commit }, posts) {
    commit('setPosts', posts)
  },
  removePost ({ commit }, postData) {
    commit('removePost', postData)
  },
  addLikeUser ({ commit }, user) {
    commit('addLikeUser', user)
  },
  removeLikeUser ({ commit }, likeUser) {
    commit('removeLikeUser', likeUser)
  },
  addDislikeUser ({ commit }, user) {
    commit('addDislikeUser', user)
  },
  removeDislikeUser ({ commit }, dislikeUser) {
    commit('removeDislikeUser', dislikeUser)
  },
  newSort ({ commit }) {
    commit('newSort')
  },
  likeSort ({ commit }) {
    commit('likeSort')
  }
}
