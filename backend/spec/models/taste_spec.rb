require 'rails_helper'

RSpec.describe Taste, type: :model do
  describe 'バリデーションに関するテスト' do
    context '正常値の場合' do
      let(:taste) { build(:taste) }

      it 'インスタンスは有効である' do
        expect(taste).to be_valid
      end
    end

    context 'contentがnilの場合' do
      let(:taste) { build(:taste, content: nil) }

      it 'インスタンスは有効ではない' do
        expect(taste).to be_invalid
      end
    end

    context 'contentが重複する場合' do
      let!(:taste) { create(:taste) }
      let(:new_taste) { build(:taste, content: taste.content) }

      it 'インスタンスは有効ではない' do
        expect(new_taste).to be_invalid
      end
    end
  end
end
