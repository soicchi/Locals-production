export const state = () => ({
  bookMarks: [],
})

export const getters = {
  bookMarks: state => state.bookMarks,
}

export const mutations = {
  setBookMarks(state, bookMarks) {
    state.bookMarks = bookMarks
  },
  addBookMarks(state, postData) {
    state.bookMarks.unshift(postData)
  },
  removeBookMarks(state,postData) {
    state.bookMarks = state.bookMarks.filter(bookMark => {
      return bookMark !== postData
    })
  }
}

export const actions = {
  async getBookMarks({ commit }) {
    await this.$axios.get('/users/book_mark_posts')
    .then(res => {
      commit('setBookMarks', res.data)
    })
  },
  addBookMarks({ commit }, postData) {
    commit('addBookMarks', postData)
  },
  removeBookMarks({ commit }, postData) {
    commit('removeBookMarks', postData)
  }
}