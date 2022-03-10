export const state = () => ({
  categories: [],
})

export const getters = {
  categories: state => state.categories,
}

export const mutations = {
  setCategories (state, categories) {
    state.categories = categories
  },
  removeCategory (state, categoryId) {
    state.categories = state.categories.filter((category) => {
      return category.id !== categoryId
    })
  }
}

export const actions = {
  async getCategories ({ commit }) {
    await this.$axios.get('/categories')
      .then((res) => {
        commit('setCategories', res.data)
      })
  },
  setCategories ({ commit }, categories) {
    commit('setCategories', categories)
  },
  removeCategory ({ commit }, categoryId) {
    commit('removeCategory', categoryId)
  }
}
