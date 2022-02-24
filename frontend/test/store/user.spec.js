import { createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import * as user from '~/store/user'
// axiosのテストの実装については保留
// import axios from 'axios'

const localVue = createLocalVue()
localVue.use(Vuex)
let store

beforeEach(() => {
  store = new Vuex.Store(user)
})

const exampleUser = {
  name: 'example',
  email: 'example@example.com',
  birth_place: '北海道',
  birth_year: 1,
  birth_month: 1,
  birth_day: 1,
  gender: 'man',
  introduction: '',
  image: '',
}

describe('mutations', () => {
  test('ユーザーデータをuserにセットする', () => {
    store.commit('setUser', exampleUser)
    expect(store.state.user).toEqual(exampleUser)
  })

  test('following情報をloggedInUserにセットする', () => {
    store.commit('setLoggedInUserFollowing', exampleUser)
    expect(store.state.loggedInUser.following).toEqual(exampleUser)
  })
})

describe('actions', () => {
  test('ログインユーザーをstoreに格納する', () => {
    store.dispatch('setLoggedInUser', exampleUser)
    expect(store.state.loggedInUser).toEqual(exampleUser)
  })

  test('格納していたログインユーザーを削除する', () => {
    store.dispatch('resetLoggedInUser')
    expect(store.state.loggedInUser).toEqual({})
  })
})
