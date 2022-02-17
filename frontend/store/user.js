export const state = () => ({
  user: {},
  loggedInUser: {}
})

export const getters = {
  user: state => state.user,
  loggedInUser: state => state.loggedInUser
}

export const mutations = {
  setUser(state, userData) {
    state.user = userData
  },
  setLoggedInUser(state, userData) {
    state.loggedInUser = userData
  },
  resetLoggedInUser(state) {
    state.loggedInUser = {}
  },
  setLoggedInUserFollowing(state, following) {
    state.loggedInUser.following = following
  },
  addLoggedInUserFollowing(state, followed) {
    state.loggedInUser.following.unshift(followed)
  },
  removeLoggedInUserFollowing(state, followed) {
    state.loggedInUser.following = state.loggedInUser.following.filter(user => {
      return user !== followed
    })
  },
  setLoggedInUserBookMarks(state, bookMarks) {
    state.loggedInUser.bookMarks = bookMarks
  },
  addLoggedInUserBookMark(state, bookMark) {
    state.loggedInUser.bookMarks.unshift(bookMark)
  },
  removeLoggedInUserBookMark(state, post) {
    state.loggedInUser.bookMarks = state.loggedInUser.bookMarks.filter(bookMark => {
      return bookMark.id !== post.id
    })
  },
  setLoggedInUserLikedPosts(state, likedPostsIds) {
    state.loggedInUser.likedPosts = likedPostsIds
  },
  addLoggedInUserLikedPost(state, likedPostId) {
    state.loggedInUser.likedPosts.unshift(likedPostId)
  },
  removeLoggedInUserLikedPost(state, postId) {
    state.loggedInUser.likedPosts = state.loggedInUser.likedPosts.filter(likedPost => {
      return likedPost !== postId
    })
  },
  setLoggedInUserDislikedPosts(state, dislikedPostsIds) {
    state.loggedInUser.dislikedPosts = dislikedPostsIds
  },
  addLoggedInUserDislikedPost(state, dislikedPostId) {
    state.loggedInUser.dislikedPosts.unshift(dislikedPostId)
  },
  removeLoggedInUserDislikedPost(state, postId) {
    state.loggedInUser.dislikedPosts = state.loggedInUser.dislikedPosts.filter(dislikePost => {
      return dislikePost !== postId
    })
  }
}

export const actions = {
  async getUser({ commit }, userId) {
    await this.$axios.get(`/users/${userId}`)
    .then(res => {
      commit('setUser', res.data)
      commit('relationShip/setFollowing', res.data.following, { root: true })
      commit('relationShip/setFollowers', res.data.followers, { root: true })
      commit('bookMark/setBookMarks', res.data.book_mark_posts, { root: true })
      commit('like/setLikedPosts', res.data.liked_posts, { root: true })
    })
  },
  async setLoggedInUserFollowing({ commit }, userId) {
    await this.$axios.get(`/users/${userId}`)
    .then(res => {
      commit('setLoggedInUserFollowing', res.data.following)
    })
  },
  async setLoggedInUserBookMarks({ commit }) {
    await this.$axios.get('/users/book_mark_posts')
    .then(res => {
      commit('setLoggedInUserBookMarks', res.data)
    })
  },
  async setLoggedInUserLikedPosts({ commit }) {
    await this.$axios.get('/users/liked_posts_ids')
    .then(res => {
      commit('setLoggedInUserLikedPosts', res.data)
    })
  },
  async setLoggedInUserDislikedPosts({ commit }) {
    await this.$axios.get('/users/disliked_posts_ids')
    .then(res => {
      commit('setLoggedInUserDislikedPosts', res.data)
    })
  },
  setUser({ commit }, userData) {
    commit('setUser', userData)
  },
  setLoggedInUser({ commit }, userData) {
    commit('setLoggedInUser', userData)
  },
  resetLoggedInUser({ commit }) {
    commit('resetLoggedInUser')
  },
  addLoggedInUserFollowing({ commit }, followed) {
    commit('addLoggedInUserFollowing', followed)
  },
  removeLoggedInUserFollowing({ commit }, followed) {
    commit('removeLoggedInUserFollowing', followed)
  },
  addLoggedInUserBookMark({ commit }, bookMark) {
    commit('addLoggedInUserBookMark', bookMark)
  },
  removeLoggedInUserBookMark({ commit }, post) {
    commit('removeLoggedInUserBookMark', post)
  },
  addLoggedInUserLikedPost({ commit }, likedPostId) {
    commit('addLoggedInUserLikedPost', likedPostId)
  },
  removeLoggedInUserLikedPost({ commit }, postId) {
    commit('removeLoggedInUserLikedPost', postId)
  },
  addLoggedInUserDislikedPost({ commit }, dislikedPostId) {
    commit('addLoggedInUserDislikedPost', dislikedPostId)
  },
  removeLoggedInUserDislikedPost({ commit }, postId) {
    commit('removeLoggedInUserDislikedPost', postId)
  }
}