import { createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import * as storeBookMark from '~/store/bookMark'

const localVue = createLocalVue()
localVue.use(Vuex)
let store

beforeEach(() => {
  store = new Vuex.Store(storeBookMark)
})
const post1 = {
  comment: 'comment1',
  restaurant_name: 'name1'
}
const post2 = {
  comment: 'comment2',
  restaurant_name: 'name2'
}

const bookMarks = [
  post1,
  post2
]

describe('mutations', () => {
  test('ブックマークが格納される', () => {
    store.commit('setBookMarks', bookMarks)
    expect(store.state.bookMarks).toEqual(bookMarks)
  })
})