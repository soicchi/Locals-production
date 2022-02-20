require 'rails_helper'

RSpec.describe BookMark, type: :model do
  describe 'バリデーションに関するテスト' do
    let!(:user) { create(:user) }
    let!(:post) { user.posts.create(attributes_for(:post)) }
    let!(:book_mark) { user.book_marks.create(post_id: post.id) }

    context 'user_idが存在しない場合' do
      let(:book_mark_params) { { user_id: nil, post_id: post.id } }

      it 'インスタンスは有効ではない' do
        expect(BookMark.new(book_mark_params)).to be_invalid
      end
    end

    context 'post_idが存在しない場合' do
      let(:book_mark_params) { { user_id: user.id, post_id: nil } }

      it 'インスタンスは有効ではない' do
        expect(BookMark.new(book_mark_params)).to be_invalid
      end
    end

    context 'userが同じ投稿をブックマークした場合' do
      let(:new_book_mark) { user.book_marks.build(post_id: post.id) }

      it 'インスタンスは有効ではない' do
        expect(new_book_mark).to be_invalid
      end
    end
  end
end
