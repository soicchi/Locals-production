export const state = () => ({
  likedPosts: [],
})

export const getters = {
  likedPosts: state => state.likedPosts,
  likedPostsCount: state => state.likedPosts.length,
}

export const mutations = {
  setLikedPosts (state, posts) {
    state.likedPosts = posts
  },
}
