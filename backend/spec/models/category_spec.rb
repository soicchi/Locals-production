require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'バリデーションに関するテスト' do
    context 'nameがnilの場合' do
      let(:category) { build(:category, name: nil) }

      it 'インスタンスは有効ではない' do
        expect(category).to be_invalid
      end
    end

    context 'nameが重複する場合' do
      let!(:category) { create(:category) }
      let(:new_category) { build(:category, name: category.name) }

      it 'インスタンスは有効ではない' do
        expect(new_category).to be_invalid
      end
    end
  end

  describe 'アソシエーションに関するテスト' do
    let!(:category) { create(:category) }
    let!(:post) { create(:post, category_ids: [category.id]) }

    context 'categoryが削除される場合' do
      let!(:classifications_count) { category.classifications.count }

      it '紐づく中間テーブルのclassificationも削除される' do
        expect { category.destroy }.to change { Category.count }.by(-classifications_count)
      end
    end
  end

  describe 'モデルメソッドに関するテスト' do
    let!(:category1) { create(:category, name: '焼き肉') }
    let!(:category2) { create(:category, name: 'その他') }
    let!(:category3) { create(:category, name: 'すき焼き') }

    context 'self.order_category_list' do
      it 'カテゴリーが昇順でかつその他が一番うしろに置かれた配列が返ってくる' do
        expect(Category.order_category_list).to match_array([category3, category1, category2])
      end
    end
  end
end
