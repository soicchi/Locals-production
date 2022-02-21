require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'モデルのバリデーションに関するテスト' do
    let!(:user) { create(:user) }

    context 'commentが255文字以内の場合' do
      let(:post) { build(:post, :valid_comment, user_id: user.id) }

      it 'インスタンスは有効である' do
        expect(post).to be_valid
      end
    end

    context 'commentが256文字以上の場合' do
      let(:post) { build(:post, :invalid_comment, user_id: user.id) }

      it 'インスタンスは有効ではない' do
        expect(post).to be_invalid
      end
    end

    context 'restaurant_nameがnilの場合' do
      let(:post) { build(:post, restaurant_name: nil) }

      it 'インスタンスは有効ではない' do
        expect(post).to be_invalid
      end
    end

    context 'stationがnilの場合' do
      let(:post) { build(:post, station: nil) }

      it 'インスタンスは有効ではない' do
        expect(post).to be_invalid
      end
    end

    context 'imagesのフォーマットが正しい場合' do
      let(:post) { build(:post, user_id: user.id) }

      before do
        post.images.attach(Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', '5mb_image.jpg')))
      end

      it '投稿は有効である' do
        expect(post).to be_valid
      end
    end

    context 'imagesのフォーマットが正しくない場合' do
      let(:invalid_post) { build(:post, user_id: user.id) }

      before do
        invalid_post.images.attach(Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'example.txt')))
      end

      it 'インスタンスは有効ではない' do
        expect(invalid_post).to be_invalid
      end
    end

    # context 'imagesのサイズが20MBより大きい場合' do
    #   let!(:invalid_post) { build(:post, user_id: user.id) }
    #   let(:images) { [
    #     Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', '5.1mb_image.jpg')),
    #     Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', '5mb_image.jpg')),
    #     Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', '6MB_image.jpg')),
    #     Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', '10MB_image.jpg'))
    #   ] }

    #   before do
    #     invalid_post.images.attach(images)
    #   end

    #   it 'インスタンスは有効ではない' do
    #     expect(invalid_post.save).to be_invalid
    #   end
    # end

    context 'imagesのサイズが20MB以下の場合' do
      let(:post) { build(:post, user_id: user.id) }

      before do
        post.images.attach(Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', '5mb_image.jpg')))
      end

      it 'インスタンスは有効である' do
        expect(post).to be_valid
      end
    end
  end

  describe '投稿の作成順序に関するテスト' do
    let!(:first_post) { create(:post) }
    let!(:second_post) { create(:post, user_id: first_post.user.id) }

    it '投稿は降順で保存される' do
      expect(Post.all.first).to eq second_post
    end
  end

  describe 'アソシエーションに関するテスト' do
    let!(:post) { create(:post) }
    let!(:user) { create(:user) }
    let!(:book_marks) { create(:book_mark, user_id: user.id, post_id: post.id) }

    context 'userに紐付いていない場合' do
      let(:invalid_post) { build(:post, user_id: nil) }

      it 'インスタンスは有効ではない' do
        expect(invalid_post).to be_invalid
      end
    end

    context 'postが削除された場合' do
      let!(:book_marks_count) { post.book_marks.count }

      it '紐付いたブックマークも削除される' do
        expect { post.destroy }.to change { BookMark.count }.by(-book_marks_count)
      end
    end
  end

  describe 'インスタンスメソッドに関するテスト' do
      let!(:user) { create(:user) }

      context 'image_urlメソッド' do
        let(:post) { build(:post, user_id: user.id) }
        let(:not_attached_post) { build(:post, user_id: user.id) }

        it 'imagesのURLを返す' do
          expect(post.image_url).to eq [rails_storage_proxy_url(post.images.blobs[0])]
        end
      end

    context 'liked_age_groupメソッド' do
      let!(:user) { create(:user, :age_10s) }
      let!(:post) { create(:post) }
      let!(:like) { create(:like, user_id: user.id, post_id: post.id) }

      it '年代別の人数を配列で返す' do
        expect(post.liked_age_group).to match_array([1, 0, 0, 0, 0, 0])
      end
    end

    context 'disliked_age_groupメソッド' do
      let!(:user) { create(:user, :age_10s) }
      let!(:post) { create(:post) }
      let!(:dislike) { create(:dislike, user_id: user.id, post_id: post.id) }

      it '年代別の人数を配列で返す' do
        expect(post.disliked_age_group).to match_array([1, 0, 0, 0, 0, 0])
      end
    end
  end
end
