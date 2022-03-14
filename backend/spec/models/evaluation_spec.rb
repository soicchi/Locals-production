require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  describe 'バリデーションに関するテスト' do
    let!(:post) { create(:post) }
    let!(:taste) { create(:taste) }

    context '正常値の場合' do
      let(:evaluation) { create(:evaluation, post_id: post.id, taste_id: taste.id) }

      it 'インスタンスは有効である' do
        expect(evaluation).to be_valid
      end
    end

    context 'taste_idがnilの場合' do
      let(:evaluation) { build(:evaluation, post_id: post.id, taste_id: nil) }

      it 'インスタンスは有効である' do
        expect(evaluation).to be_invalid
      end
    end

    context 'post_idとtaste_idの組み合わせが重複する場合' do
      let!(:evaluation) { create(:evaluation, post_id: post.id, taste_id: taste.id) }
      let!(:new_evaluation) { build(:evaluation, post_id: post.id, taste_id: taste.id) }

      it 'インスタンスは有効ではない' do
        expect(new_evaluation).to be_invalid
      end
    end
  end
end
