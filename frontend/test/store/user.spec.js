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
  id: 1,
  name: 'example',
  email: 'example@example.com',
  birth_place: '北海道',
  birth_year: 1,
  birth_month: 1,
  birth_day: 1,
  gender: 'man',
  introduction: '',
}

const loggedInUser = {
  id: 2,
  name: 'loggedInUser',
  email: 'guest@example.com',
  birth_place: '北海道',
  birth_year: 1,
  birth_month: 1,
  birth_day: 1,
  gender: 'man',
  introduction: '',
  following: [],
  bookMarks: [],
  likedPosts: [],
  dislikedPosts: [],
}

const post = {
  id: 1,
  restaurant_name: 'example_name',
  station: 'example_station',
  image_url: '',
  catagory_ids: [1],
  comment: 'example_comment',
}

describe('actions', () => {
  test('ユーザーをstoreに格納する', () => {
    store.dispatch('setUser', exampleUser)
    expect(store.state.user).toEqual(exampleUser)
  })

  test('ログインユーザーをstoreに格納する', () => {
    store.dispatch('setLoggedInUser', exampleUser)
    expect(store.state.loggedInUser).toEqual(exampleUser)
  })

  test('格納していたログインユーザーを削除する', () => {
    store.dispatch('resetLoggedInUser')
    expect(store.state.loggedInUser).toEqual({})
  })

  test('ログインユーザーのフォローリストが増える', () => {
    store.dispatch('setLoggedInUser', loggedInUser)
    store.dispatch('addLoggedInUserFollowing', exampleUser)
    expect(store.state.loggedInUser.following).toContain(exampleUser)
  })

  test('ログインユーザーのフォローリストが減る', () => {
    store.dispatch('setLoggedInUser', loggedInUser)
    store.dispatch('removeLoggedInUserFollowing', exampleUser)
    expect(store.state.loggedInUser.following).not.toContain(exampleUser)
  })

  test('ログインユーザーのブックマークリストが増える', () => {
    store.dispatch('setLoggedInUser', loggedInUser)
    store.dispatch('addLoggedInUserBookMark', post)
    expect(store.state.loggedInUser.bookMarks).toContain(post)
  })

  test('ログインユーザーのブックマークリストが減る', () => {
    store.dispatch('setLoggedInUser', loggedInUser)
    store.dispatch('removeLoggedInUserBookMark', post)
    expect(store.state.loggedInUser.bookMarks).not.toContain(post)
  })

  test('ログインユーザーのいいねリストが増える', () => {
    store.dispatch('setLoggedInUser', loggedInUser)
    store.dispatch('addLoggedInUserLikedPost', post)
    expect(store.state.loggedInUser.likedPosts).toContain(post)
  })

  test('ログインユーザーのいいねリストが減る', () => {
    store.dispatch('setLoggedInUser', loggedInUser)
    store.dispatch('removeLoggedInUserLikedPost', post)
    expect(store.state.loggedInUser.likedPosts).not.toContain(post)
  })

  test('ログインユーザーのう〜んリストが増える', () => {
    store.dispatch('setLoggedInUser', loggedInUser)
    store.dispatch('addLoggedInUserDislikedPost', post)
    expect(store.state.loggedInUser.dislikedPosts).toContain(post)
  })

  test('ログインユーザーのう〜んリストが減る', () => {
    store.dispatch('setLoggedInUser', loggedInUser)
    store.dispatch('removeLoggedInUserDislikedPost', post)
    expect(store.state.loggedInUser.dislikedPosts).not.toContain(post)
  })
})
