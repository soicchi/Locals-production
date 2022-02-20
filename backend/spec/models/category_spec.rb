require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'バリデーションに関するテスト' do
    context 'nameがnilの場合' do
      let(:category) { build(:category, name: nil) }

      it 'インスタンスは有効ではない' do
        expect(category).to be_invalid
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
end
