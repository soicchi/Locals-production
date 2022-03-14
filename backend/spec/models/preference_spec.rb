require 'rails_helper'

RSpec.describe Preference, type: :model do
  describe 'バリデーションに関するテスト' do
    let!(:user) { create(:user) }
    let!(:taste) { create(:taste) }

    context '正常値の場合' do
      let(:preference) { build(:preference, user_id: user.id, taste_id: taste.id) }

      it 'インスタンスは有効である' do
        expect(preference).to be_valid
      end
    end

    context 'user_idがnilの場合' do
      let(:preference) { build(:preference, user_id: nil, taste_id: taste.id) }

      it 'インスタンスは有効ではない' do
        expect(preference).to be_invalid
      end
    end

    context 'taste_idがnilの場合' do
      let(:preference) { build(:preference, user_id: user.id, taste_id: nil) }

      it 'インスタンスは有効ではない' do
        expect(preference).to be_invalid
      end
    end

    context 'user_idとtaste_idの組み合わせが重複する場合' do
      let!(:preference) { create(:preference, user_id: user.id, taste_id: taste.id) }
      let(:new_preference) { build(:preference, user_id: user.id, taste_id: taste.id) }

      it 'インスタンスは有効ではない' do
        expect(new_preference).to be_invalid
      end
    end
  end
end
