require 'rails_helper'

RSpec.describe "Api::V1::Relationships", type: :request do
  describe "POST /create" do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let(:auth_tokens) { sign_in user1 }
    let(:success_message) { 'フォローしました' }

    before do
      post api_v1_relationships_path, params: { user_id: user2.id }, headers: auth_tokens
    end

    it 'ステータスコード200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'user2をフォローできる' do
      expect(user1.following).to include user2
    end

    it 'メッセージが返ってくる' do
      expect(json['message']).to eq success_message
    end
  end

  describe 'DELETE /destroy' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let(:auth_tokens) { sign_in user1 }
    let(:success_message) { 'フォローを解除しました' }

    before do
      user1.follow(user2)
      delete api_v1_relationship_path(user2.id), headers: auth_tokens
    end

    it 'ステータスコード200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'user1のfollowingにuser2は含まれていない' do
      expect(user1.following.reload).not_to include user2
    end

    it 'メッセージが返ってくる' do
      expect(json['message']).to eq success_message
    end
  end
end
