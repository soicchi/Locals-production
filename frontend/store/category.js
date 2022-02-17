export const state = () => ({
  categories: []
})

export const getters = {
  categories: state => state.categories
}

export const mutations = {
  setCategories(state, categories) {
    state.categories = categories
  }
}

export const actions = {
  async getCategories({ commit }) {
    await this.$axios.get('/categories')
    .then(res => {
      commit('setCategories', res.data)
    })
  }
}