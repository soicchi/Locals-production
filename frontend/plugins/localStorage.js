import createPersistedState from 'vuex-persistedstate'

export default ({ store, req, isDev }) => {
  createPersistedState({
    key: 'locals',
    paths: [
      'user.loggedInUser',
    ],
  })(store)
}
