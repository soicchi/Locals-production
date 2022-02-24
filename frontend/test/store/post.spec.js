import { createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import * as post from '~/store/post'

const localVue = createLocalVue()
localVue.use(Vuex)
let store

beforeEach(() => {
  store = new Vuex.Store(post)
})

const postData = {
  content: 'exampleContent',
  restaurant_name: 'exampleRestaurant',
  user: {
    name: 'example',
    email: 'example@example.com',
    birth_place: '北海道',
    birth_year: 1,
    birth_month: 1,
    birth_day: 1,
    gender: 'man',
    introduction: '',
    image: '',
  },
}

describe('mutations', () => {
  test('該当する投稿データの配列が格納される', () => {
    store.commit('setPosts', postData)
    expect(store.state.posts).toEqual(postData)
  })

  test('該当する投稿データが格納される', () => {
    store.commit('setPost', postData)
    expect(store.state.post).toEqual(postData)
  })
})
