import { createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import * as storeMessage from '~/store/message'

const localVue = createLocalVue()
localVue.use(Vuex)

describe('エラーメッセージテスト', () => {
  let store
  const messages = ['エラーメッセージ']

  beforeEach(() => {
    store = new Vuex.Store(storeMessage)
  })

  test('エラーメッセージを格納する', () => {
    store.dispatch('setMessages', { messages: messages, type: 'error' })
    expect(store.getters.messages).toEqual(messages)
    expect(store.getters.type).toEqual('error')
    expect(store.getters.existed).toEqual(true)
  })
})