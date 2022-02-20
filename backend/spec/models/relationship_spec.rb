require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'フォロー、フォロワーの関係性に関するテスト' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }

    context 'follower_idがnilの場合' do
      let(:relationship_params) { { followed_id: user1, follower_id: nil } }

      it 'インスタンスは有効ではない' do
        expect(Relationship.new(relationship_params)).to be_invalid
      end
    end

    context 'followed_idがnilの場合' do
      let(:relationship_params) { { followed_id: nil, follower_id: user2 } }

      it 'インスタンスは有効ではない' do
        expect(Relationship.new(relationship_params)).to be_invalid
      end
    end
  end
end
