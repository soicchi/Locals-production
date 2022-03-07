export const state = () => ({
  user: {},
  loggedInUser: {},
})

export const getters = {
  user: state => state.user,
  loggedInUser: state => state.loggedInUser,
  followingCount: state => state.user.following.length,
  followersCount: state => state.user.followers.length,
  likedPostsCount: state => state.user.liked_posts.length,
}

export const mutations = {
  setUser (state, userData) {
    state.user = userData
  },
  setLoggedInUser (state, userData) {
    state.loggedInUser = userData
  },
  resetLoggedInUser (state) {
    state.loggedInUser = {}
  },
  addLoggedInUserFollowing (state, followed) {
    state.loggedInUser.following.unshift(followed)
  },
  removeLoggedInUserFollowing (state, followed) {
    state.loggedInUser.following = state.loggedInUser.following.filter((user) => {
      return user.id !== followed.id
    })
  },
  addLoggedInUserBookMark (state, bookMark) {
    state.loggedInUser.book_mark_posts.unshift(bookMark)
  },
  removeLoggedInUserBookMark (state, post) {
    state.loggedInUser.book_mark_posts = state.loggedInUser.book_mark_posts.filter((bookMark) => {
      return bookMark.id !== post.id
    })
  },
  addLoggedInUserLikedPost (state, likedPostId) {
    state.loggedInUser.liked_posts.unshift(likedPostId)
  },
  removeLoggedInUserLikedPost (state, postId) {
    state.loggedInUser.liked_posts = state.loggedInUser.liked_posts.filter((likedPost) => {
      return likedPost !== postId
    })
  },
  addLoggedInUserDislikedPost (state, dislikedPostId) {
    state.loggedInUser.disliked_posts.unshift(dislikedPostId)
  },
  removeLoggedInUserDislikedPost (state, postId) {
    state.loggedInUser.disliked_posts = state.loggedInUser.disliked_posts.filter((dislikePost) => {
      return dislikePost !== postId
    })
  },
}

export const actions = {
  async getUser ({ commit }, userId) {
    await this.$axios.get(`/users/${userId}`)
      .then((res) => {
        commit('setUser', res.data)
      })
  },
  async getLoggedInUser ({ commit }) {
    await this.$axios.get('/current_users')
      .then((res) => {
        commit('setLoggedInUser', res.data)
      })
  },
  setLoggedInUser ({ commit }, userData) {
    commit('setLoggedInUser', userData)
  },
  resetLoggedInUser ({ commit }) {
    commit('resetLoggedInUser')
  },
  addLoggedInUserFollowing ({ commit }, followed) {
    commit('addLoggedInUserFollowing', followed)
  },
  removeLoggedInUserFollowing ({ commit }, followed) {
    commit('removeLoggedInUserFollowing', followed)
  },
  addLoggedInUserBookMark ({ commit }, bookMark) {
    commit('addLoggedInUserBookMark', bookMark)
  },
  removeLoggedInUserBookMark ({ commit }, post) {
    commit('removeLoggedInUserBookMark', post)
  },
  addLoggedInUserLikedPost ({ commit }, likedPostId) {
    commit('addLoggedInUserLikedPost', likedPostId)
  },
  removeLoggedInUserLikedPost ({ commit }, postId) {
    commit('removeLoggedInUserLikedPost', postId)
  },
  addLoggedInUserDislikedPost ({ commit }, dislikedPostId) {
    commit('addLoggedInUserDislikedPost', dislikedPostId)
  },
  removeLoggedInUserDislikedPost ({ commit }, postId) {
    commit('removeLoggedInUserDislikedPost', postId)
  },
}
