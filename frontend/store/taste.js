export const state = () => ({
  tastes: [],
})

export const getters = {
  tastes: state => state.tastes,
}

export const mutations = {
  setTastes (state, tastes) {
    state.tastes = tastes
  },
}

export const actions = {
  async getTastes ({ commit }) {
    await this.$axios.get('/tastes')
      .then((res) => {
        commit('setTastes', res.data)
      })
  },
}
