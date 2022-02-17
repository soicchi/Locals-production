export const state = () => ({
  messages: [],
  type: '',
  existed: false,
})

export const getters = {
  messages: state => state.messages,
  type: state => state.type,
  existed: state => state.existed,
}

export const mutations = {
  setMessages (state, message) {
    state.messages = message
  },
  existedMessage (state) {
    state.existed = true
  },
  notExistedMessage (state) {
    state.existed = false
  },
  setType (state, type) {
    state.type = type
  },
}

export const actions = {
  setMessages ({ commit }, { messages, type }) {
    commit('setMessages', messages)
    commit('setType', type)
    commit('existedMessage')
    setTimeout(() => {
      commit('notExistedMessage')
    }, 3000)
  },
}
