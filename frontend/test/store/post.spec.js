import { createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import * as post from '~/store/post'

const localVue = createLocalVue()
localVue.use(Vuex)
let store

beforeEach(() => {
  store = new Vuex.Store(post)
})

const post2 = {
  id: 2,
  restaurant_name: 'exampleRestaurant',
  station: 'exampleStation',
  comment: 'exampleComment',
  image_url: [],
  category_ids: [1],
  like_users: [],
  dislike_users: [],
}

const user = {
  id: 2,
  name: 'user',
  email: 'guest@example.com',
  birth_place: '北海道',
  birth_year: 1,
  birth_month: 1,
  birth_day: 1,
  gender: 'man',
  introduction: '',
}

describe('actions', () => {
  test('該当する投稿データの配列が格納される', () => {
    store.dispatch('setPosts', [post2])
    expect(store.state.posts).toEqual([post2])
  })

  test('該当する透谷データを格納している配列から削除する', () => {
    store.dispatch('setPosts', [post2])
    store.dispatch('removePost', post2)
    expect(store.state.posts).not.toContain(post2)
  })

  test('該当する投稿データのlike_usersが増える', () => {
    store.commit('setPost', post2)
    store.dispatch('addLikeUser', user)
    expect(store.state.post.like_users).toContain(user)
  })

  test('該当する投稿データのlike_usersが減る', () => {
    store.commit('setPost', post2)
    store.dispatch('removeLikeUser', user)
    expect(store.state.post.like_users).not.toContain(user)
  })

  test('該当する投稿データのdislike_usersが増える', () => {
    store.commit('setPost', post2)
    store.dispatch('addDislikeUser', user)
    expect(store.state.post.dislike_users).toContain(user)
  })

  test('該当する投稿データのdislike_usersが減る', () => {
    store.commit('setPost', post2)
    store.dispatch('removeDislikeUser', user)
    expect(store.state.post.dislike_users).not.toContain(user)
  })
})
