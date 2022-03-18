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
        post.images.attach(Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'image.jpg')))
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

    context 'imagesのサイズが5MB以上の場合' do
      let(:post) { build(:post, user_id: user.id) }

      before do
        post.images.attach(Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', '5.1mb_image.jpg')))
      end

      it 'インスタンスは有効ではない' do
        expect(post).to be_invalid
      end
    end

    context 'imagesのサイズが5MB以下の場合' do
      let(:post) { build(:post, user_id: user.id) }

      before do
        post.images.attach(Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'image.jpg')))
      end

      it 'インスタンスは有効である' do
        expect(post).to be_valid
      end
    end

    context 'taste_idsがnilの場合' do
      let(:post) { build(:post, taste_ids: nil) }

      it 'インスタンスは有効ではない' do
        expect(post).to be_invalid
      end
    end

    context 'taste_idが1つのの場合' do
      let!(:user) { create(:user) }
      let!(:taste) { create(:taste) }
      let(:post) { build(:post, user_id: user.id, taste_ids: [taste.id]) }

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

  describe 'image_urlメソッドに関するテスト' do
    let!(:user) { create(:user) }
    let(:post) { build(:post, user_id: user.id) }
    let(:not_attached_post) { build(:post, user_id: user.id) }

    it 'imagesのURLを返す' do
      expect(post.image_url).to eq [url_for(post.images.blobs[0].variant(resize_to_limit: [200, 200]))]
    end
  end

  describe 'liked_age_groupメソッドに関するテスト' do
    let!(:user) { create(:user, :age_10s) }
    let!(:post) { create(:post) }
    let!(:like) { create(:like, user_id: user.id, post_id: post.id) }

    it '年代別の人数を配列で返す' do
      expect(post.liked_age_group).to match_array([1, 0, 0, 0, 0, 0])
    end
  end

  describe 'disliked_age_groupメソッドに関するテスト' do
    let!(:user) { create(:user, :age_10s) }
    let!(:post) { create(:post) }
    let!(:dislike) { create(:dislike, user_id: user.id, post_id: post.id) }

    it '年代別の人数を配列で返す' do
      expect(post.disliked_age_group).to match_array([1, 0, 0, 0, 0, 0])
    end
  end

  describe 'like_percentageメソッド' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:post) { create(:post) }
    let!(:like) { create(:like, user_id: user.id, post_id: post.id) }
    let!(:dislike) { create(:dislike, user_id: other_user.id, post_id: post.id) }
    let(:percent) { post.like_users.length.to_f / (post.like_users.length.to_f + post.dislike_users.length.to_f) * 100 }

    context 'percentのlike_usersとdislike_usersが0ではない場合' do
      it 'いいね率を返す' do
        expect(post.like_percentage).to eq percent.round
      end
    end

    context 'percentのlike_usersとdislike_usersが0の場合' do
      let!(:other_post) { create(:post) }

      it 'いいね率を0で返す' do
        expect(other_post.like_percentage).to eq 0
      end
    end
  end

  describe 'favorite_rate_groupメソッドに関するテスト' do
    let!(:user) { create(:user, :age_10s) }
    let!(:post) { create(:post) }
    let!(:like) { create(:like, user_id: user.id, post_id: post.id) }

    it '年代別のいいね率を配列で返す' do
      expect(post.favorite_rate_group).to match_array([100, 0, 0, 0, 0, 0])
    end
  end
end
