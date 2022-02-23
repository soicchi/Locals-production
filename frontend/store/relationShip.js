export const state = () => ({
  following: [],
  followers: [],
})

export const getters = {
  following: state => state.following,
  followers: state => state.followers,
  followingCount: state => state.following.length,
  followersCount: state => state.followers.length,
}

export const mutations = {
  setFollowing (state, following) {
    state.following = following
  },
  setFollowers (state, followers) {
    state.followers = followers
  },
}
