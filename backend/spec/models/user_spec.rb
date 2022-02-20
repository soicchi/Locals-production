require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションに関するテスト' do
    context 'すべての値が正常な場合' do
      let(:user_params) { attributes_for(:user) }

      it 'インスタンスが有効である' do
        expect(User.new(user_params)).to be_valid
      end
    end

    context 'nameがnilの場合' do
      let(:user_params) { attributes_for(:user, name: nil) }

      it 'インスタンスは有効ではない' do
        expect(User.new(user_params)).to be_invalid
      end
    end

    context 'nameが11文字以上の場合' do
      let(:user_params) { attributes_for(:user, :over_length_name) }

      it 'インスタンスは有効ではない' do
        expect(User.new(user_params)).to be_invalid
      end
    end

    context '既存のnameと重複する場合' do
      let!(:user) { create(:user) }
      let(:user_params) { attributes_for(:user, name: user.name) }

      it 'インスタンスは有効ではない' do
        expect(User.new(user_params)).to be_invalid
      end
    end

    context 'emailがnilの場合' do
      let(:user_params) { attributes_for(:user, email: nil) }

      it 'インスタンスは有効ではない' do
        expect(User.new(user_params)).to be_invalid
      end
    end

    context '既存のemailと新規登録のemailが大文字、小文字区別なく重複する場合' do
      let!(:user) { create(:user) }
      let(:user_params) { attributes_for(:user, email: user.email.upcase) }

      it 'インスタンスは有効ではない' do
        expect(User.new(user_params)).to be_invalid
      end
    end

    context 'emailのフォーマットが間違っている場合' do
      let(:user_params) { attributes_for(:user, :invalid_email) }

      it 'インスタンスは有効ではない' do
        expect(User.new(user_params)).to be_invalid
      end
    end

    context 'birth_placeがnilの場合' do
      let(:user_params) { attributes_for(:user, birth_place: nil) }

      it 'インスタンスは有効ではない' do
        expect(User.new(user_params)).to be_invalid
      end
    end

    context 'birth_yearがnilの場合' do
      let(:user_params) { attributes_for(:user, birth_year: nil) }

      it 'インスタンスは有効ではない' do
        expect(User.new(user_params)).to be_invalid
      end
    end

    context 'birth_monthがnilの場合' do
      let(:user_params) { attributes_for(:user, birth_month: nil) }

      it 'インスタンスは有効ではない' do
        expect(User.new(user_params)).to be_invalid
      end
    end

    context 'birth_dayがnilの場合' do
      let(:user_params) { attributes_for(:user, birth_day: nil) }

      it 'インスタンスは有効ではない' do
        expect(User.new(user_params)).to be_invalid
      end
    end

    context 'genderがnilの場合' do
      let(:user_params) { attributes_for(:user, gender: nil) }

      it 'インスタンスは有効ではない' do
        expect(User.new(user_params)).to be_invalid
      end
    end

    context 'introductionが256文字以上の場合' do
      let(:user_params) { attributes_for(:user, :over_length_introduction) }

      it 'インスタンスは有効ではない' do
        expect(User.new(user_params)).to be_invalid
      end
    end

    context 'introductionが255文字以内の場合' do
      let(:user_params) { attributes_for(:user, :valid_introduction) }

      it 'インスタンスは有効である' do
        expect(User.new(user_params)).to be_valid
      end
    end

    context 'introductionがnilの場合' do
      let(:user) { build(:user, introduction: nil) }

      it 'インスタンスは有効である' do
        expect(user).to be_valid
      end
    end

    # context 'avatarが有効なcontent_typeの場合' do
    #   let(:user) { build(:user, :with_avatar) }

    #   it 'インスタンスは有効である' do
    #     expect(user).to be_valid
    #   end
    # end

    # context 'avatarが無効なcontent_typeの場合' do
    #   let!(:user) { build(:user, :with_invalid_format_avatar) }

    #   it 'インスタンスは有効ではない' do
    #     expect(user).to be_invalid
    #   end
    # end

    # context 'avatarのファイルサイズが5MBより大きい場合' do
    #   let(:user) { build(:user, :with_over_size_avatar) }

    #   it 'インスタンスは有効ではない' do
    #     expect(user).to be_invalid
    #   end
    # end
  end

  ##################################
  # モデルのメソッドに関するテスト #
  ##################################

  describe 'モデルのメソッドに関するテスト' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:other_user_post) { create(:post, user_id: other_user.id) }

    context 'followメソッド' do
      before do
        user.follow other_user
      end

      it 'userはother_userをフォローしている' do
        expect(user.following).to include other_user
      end

      it 'following?メソッドがtrueを返す' do
        expect(user.following? other_user).to eq true
      end
    end

    context 'unfollowメソッド' do
      let!(:relationships) { Relationship.create(followed_id: other_user.id, follower_id: user.id) }

      before do
        user.unfollow other_user
      end

      it 'userはother_userをフォローしていない' do
        expect(user.following).not_to include other_user
      end

      it 'following?メソッドがfalseを返す' do
        expect(user.following? other_user).to eq false
      end
    end

    context 'following_feedメソッド' do
      let!(:user_post) { create(:post, user_id: user.id) }
      let!(:not_follow_user_post) { create(:post) }
      let!(:relationships) { Relationship.create(followed_id: other_user.id, follower_id: user.id) }

      it 'フォローしているユーザーの投稿と自身の投稿が返ってくる' do
        expect(user.following_feed).to match_array([user_post, other_user_post])
      end

      it 'フォローしていないユーザーの投稿は含まれていない' do
        expect(user.following_feed).not_to include not_follow_user_post
      end
    end

    #   context 'book_markメソッド' do
    #     before do
    #       user.book_mark other_user_post
    #     end

    #     it 'ブックマークが作成される' do
    #       expect(user.book_mark_posts).to include other_user_post
    #     end
    #   end

    #   context 'remove_book_markメソッド' do
    #     let!(:book_mark) { create(:book_mark, user_id: user.id, post_id: other_user_post.id) }

    #     before do
    #       user.remove_book_mark other_user_post
    #     end

    #     it 'userのブックマークしている投稿には含まれていない' do
    #       expect(user.book_mark_posts).not_to include other_user_post
    #     end
    #   end

    #   context 'likeメソッド' do
    #     before do
    #       user.like other_user_post
    #     end

    #     it 'userはother_user_postをいいねしている' do
    #       expect(user.liked_posts).to include other_user_post
    #     end

    #     it 'liked?メソッドがtrueを返す' do
    #       expect(user.liked? other_user_post).to be true
    #     end
    #   end

    #   context 'unlikeメソッド' do
    #     let!(:like) { create(:like, user_id: user.id, post_id: other_user_post.id) }

    #     before do
    #       user.unlike other_user_post
    #     end

    #     it 'userのいいね一覧にother_userの投稿は含まれない' do
    #       expect(user.liked_posts).not_to include other_user_post
    #     end

    #     it 'liked?メソッドはfalseを返す' do
    #       expect(user.liked? other_user_post).to be false
    #     end
    #   end

    #   context 'dislikeメソッド' do
    #     before do
    #       user.dislike other_user_post
    #     end

    #     it 'userはother_user_postにう〜んの評価をしている' do
    #       expect(user.disliked_posts).to include other_user_post
    #     end

    #     it 'disliked?メソッドはtrueを返す' do
    #       expect(user.disliked? other_user_post).to be true
    #     end
    #   end

    #   context 'undislikeメソッド' do
    #     let!(:dislike) { create(:dislike, user_id: user.id, post_id: other_user_post.id) }

    #     before do
    #       user.undislike(other_user_post)
    #     end

    #     it 'userのう〜んの評価をした投稿一覧にother_user_postは含まれない' do
    #       expect(user.disliked_posts).not_to include other_user_post
    #     end

    #     it 'disliked?メソッドはfalseを返す' do
    #       expect(user.disliked? other_user_post).to be false
    #     end
    #   end

    #   context 'avatar_urlメソッド' do
    #     let(:attached_user) { build(:user) }

    #     before do
    #       attached_user.avatar.attach(Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', '510534.jpg')))
    #     end

    #     it 'with_avatar_userのavatarのURLが返ってくる' do
    #       expect(attached_user.avatar_url).to eq rails_storage_proxy_url attached_user.avatar
    #     end

    #     it 'avatarがattachされてないuserはnilが返ってくる' do
    #       expect(user.avatar_url).to eq nil
    #     end
    #   end

    #   context 'ageメソッド' do
    #     let!(:user3) { create(:user, birth_year: 1992, birth_month: 4, birth_day: 4) }
    #     subject { user3.age }

    #     it '年齢が29で算出される' do
    #       is_expected.to eq 29
    #     end
    #   end
  end

  ##################################
  # アソシエーションに関するテスト #
  ##################################

  describe 'アソシエーションに関するテスト' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    let!(:other_user) { create(:user) }
    let!(:other_user_post1) { create(:post, user_id: other_user.id) }
    let!(:other_user_post2) { create(:post, user_id: other_user.id) }
    # let!(:active_relationships) { create(:relationship, followed_id: user.id, follower_id: other_user.id) }
    # let!(:passive_relationships) { create(:relationship, followed_id: other_user.id, follower_id: user.id) }
    # let!(:book_marks) { create(:book_mark, user_id: user.id, post_id: other_user_post1.id) }
    # let!(:likes) { create(:like, user_id: user.id, post_id: other_user_post1.id) }
    # let!(:dislikes) { create(:dislike, user_id: user.id, post_id: other_user_post2.id) }

    context 'Userが削除された場合' do
      let!(:user_posts_count) { user.posts.count }
      # let!(:user_relationships_count) { user.active_relationships.count + user.passive_relationships.count }
      # let!(:user_bookmarks_count) { user.book_marks.count }
      # let!(:user_likes_count) { user.likes.count }
      # let!(:user_dislikes_count) { user.dislikes.count }

      it '紐付いた投稿も削除される' do
        expect { user.destroy }.to change { Post.count }.by(-user_posts_count)
      end

      # it '紐付いたリレーションシップは削除される' do
      #   expect { user.destroy }.to change { Relationship.count }.by(-user_relationships_count)
      # end

      # it '紐付いたブックマークも削除される' do
      #   expect { user.destroy }.to change { BookMark.count }.by(-user_bookmarks_count)
      # end

      # it '紐付いたいいねも削除される' do
      #   expect { user.destroy }.to change { Like.count }.by(-user_likes_count)
      # end

      # it '紐付いたう〜んも削除される' do
      #   expect { user.destroy }.to change { Dislike.count }.by(-user_dislikes_count)
      # end
    end
  end
end
