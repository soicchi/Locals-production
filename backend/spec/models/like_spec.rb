require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'バリデーションに関するテスト' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:other_user_post) { create(:post, user_id: other_user.id) }

    context 'user_id, post_idの両方が存在する場合' do
      let(:like) { build(:like, user_id: user.id, post_id: other_user_post.id) }

      it 'インスタンスは有効である' do
        expect(like).to be_valid
      end
    end

    context 'user_idがnilの場合' do
      let(:like) { build(:like, post_id: other_user_post.id, user_id: nil) }

      it 'インスタンスは有効ではない' do
        expect(like).to be_invalid
      end
    end

    context 'post_idがnilの場合' do
      let(:like) { build(:like, user_id: user.id, post_id: nil) }

      it 'インスタンスは有効ではない' do
        expect(like).to be_invalid
      end
    end

    context '同じ投稿をいいねした場合' do
      let!(:like) { create(:like, user_id: user.id, post_id: other_user_post.id) }
      let(:dup_like) { build(:like, user_id: user.id, post_id: other_user_post.id) }

      it 'インスタンスは有効ではない' do
        expect(dup_like).to be_invalid
      end
    end
  end
end
