require 'rails_helper'

RSpec.describe Classification, type: :model do
  describe 'バリデーションに関するテスト' do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:user_post) { create(:post) }

    context 'post_idとcategory_idがnilではない場合' do
      let(:classification) { build(:classification, category_id: category.id, post_id: user_post.id) }

      it 'インスタンスは有効である' do
        expect(classification).to be_valid
      end
    end

    context 'post_idがnilの場合' do
      let(:classification) { build(:classification, category_id: category.id, post_id: nil) }

      it 'インスタンスは有効ではない' do
        expect(classification).to be_invalid
      end
    end

    context 'category_idがnilの場合' do
      let(:classification) { build(:classification, category_id: nil, post_id: user_post.id) }

      it 'インスタンスは有効ではない' do
        expect(classification).to be_invalid
      end
    end

    context 'post_idとcategory_idの組み合わせが重複する場合' do
      let!(:classification) { create(:classification, category_id: category.id, post_id: user_post.id) }
      let(:new_classification) { build(:classification, category_id: category.id, post_id: user_post.id) }

      it 'インスタンスは有効ではない' do
        expect(new_classification).to be_invalid
      end
    end

    describe 'モデルメソッドに関するテスト' do
      let!(:category1) { create(:category) }
      let!(:category2) { create(:category) }
      let!(:post) { create(:post, category_ids: [category1.id]) }
      let!(:other_post) { create(:post, category_ids: [category2.id]) }

      context 'self.match_all_categoriesメソッド' do
        it 'post_idが含まれている' do
          expect(Classification.match_all_categories([category1.id])).to include post.id
        end

        it '該当カテゴリー以外のother_post_idは含まれていない' do
          expect(Classification.match_all_categories([category1.id])).not_to include other_post.id
        end
      end
    end
  end
end
