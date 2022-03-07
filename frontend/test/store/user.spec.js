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
  introduction: '',
  following: [],
  book_mark_posts: [],
  liked_posts: [],
  disliked_posts: [],
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
    store.dispatch('addLoggedInUserBookMark', post.id)
    expect(store.state.loggedInUser.book_mark_posts).toContain(post.id)
  })

  test('ログインユーザーのブックマークリストが減る', () => {
    store.dispatch('setLoggedInUser', loggedInUser)
    store.dispatch('removeLoggedInUserBookMark', post.id)
    expect(store.state.loggedInUser.book_mark_posts).not.toContain(post.id)
  })

  test('ログインユーザーのいいねリストが増える', () => {
    store.dispatch('setLoggedInUser', loggedInUser)
    store.dispatch('addLoggedInUserLikedPost', post.id)
    expect(store.state.loggedInUser.liked_posts).toContain(post.id)
  })

  test('ログインユーザーのいいねリストが減る', () => {
    store.dispatch('setLoggedInUser', loggedInUser)
    store.dispatch('removeLoggedInUserLikedPost', post.id)
    expect(store.state.loggedInUser.liked_posts).not.toContain(post.id)
  })

  test('ログインユーザーのう〜んリストが増える', () => {
    store.dispatch('setLoggedInUser', loggedInUser)
    store.dispatch('addLoggedInUserDislikedPost', post.id)
    expect(store.state.loggedInUser.disliked_posts).toContain(post.id)
  })

  test('ログインユーザーのう〜んリストが減る', () => {
    store.dispatch('setLoggedInUser', loggedInUser)
    store.dispatch('removeLoggedInUserDislikedPost', post.id)
    expect(store.state.loggedInUser.disliked_posts).not.toContain(post.id)
  })
})
