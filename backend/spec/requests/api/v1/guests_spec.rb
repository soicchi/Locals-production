require 'rails_helper'

RSpec.describe "Api::V1::Guests", type: :request do
  describe "GET /create" do
    let!(:taste1) { create(:taste, id: 1) }
    let!(:taste2) { create(:taste, id: 2) }
    let!(:taste3) { create(:taste, id: 3) }

    before do
      post api_v1_guests_path
    end

    context 'ゲストユーザー作成に成功した場合' do
      it 'ステータスコード200を返す' do
        expect(response.status).to eq 200
      end

      it 'ゲストユーザーが生成される' do
        expect(User.count).to eq 1
      end
    end
  end
end
