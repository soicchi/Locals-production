require 'rails_helper'

RSpec.describe Dislike, type: :model do
  describe 'バリデーションに関するテスト' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:other_user_post) { create(:post, user_id: other_user.id) }

    context 'user_idとpost_idが存在する場合' do
      let(:dislike) { build(:dislike, user_id: user.id, post_id: other_user_post.id) }

      it 'インスタンスは有効である' do
        expect(dislike).to be_valid
      end
    end

    context 'user_idがnilの場合' do
      let(:dislike) { build(:dislike, user_id: nil, post_id: other_user_post.id) }

      it 'インスタンスは有効ではない' do
        expect(dislike).to be_invalid
      end
    end

    context 'post_idがnilの場合' do
      let(:dislike) { build(:dislike, user_id: user.id, post_id: nil) }

      it 'インスタンスは有効ではない' do
        expect(dislike).to be_invalid
      end
    end

    context 'すでに存在しているdislikeを生成する場合' do
      let!(:dislike) { create(:dislike, user_id: user.id, post_id: other_user_post.id) }
      let(:dup_dislike) { build(:dislike, user_id: user.id, post_id: other_user_post.id) }

      it 'インスタンスは有効ではない' do
        expect(dup_dislike).to be_invalid
      end
    end
  end
end
