import { createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import * as storeBookMark from '~/store/bookMark'

const localVue = createLocalVue()
localVue.use(Vuex)
let store

beforeEach(() => {
  store = new Vuex.Store(storeBookMark)
})
const bookMarkPost = {
  id: 3,
  restaurant_name: 'name1',
  station: 'station',
  image_url: [],
  category_ids: [1],
}

describe('actions', () => {
  test('ブックマークリストが増える', () => {
    store.commit('setBookMarks', [bookMarkPost])
    store.dispatch('addBookMarks', bookMarkPost)
    expect(store.state.bookMarks).toContain(bookMarkPost)
  })

  test('ブックマークが格納される', () => {
    store.commit('setBookMarks', [bookMarkPost])
    store.dispatch('removeBookMarks', bookMarkPost)
    expect(store.state.bookMarks).not.toContain(bookMarkPost)
  })
})
