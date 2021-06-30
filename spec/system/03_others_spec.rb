require 'rails_helper'

RSpec.describe 'アクセス制限のテスト' do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:book) { create(:book) }
  let!(:other_book) { create(:book)}

  describe '他人の画面のテスト' do
    context 'ユーザ詳細画面' do
      before do
        visit user_path(other_user)
      end
      it '編集ボタンが表示されない' do
        expect(page).not_to have_link '', href: edit_user_path(other_user)
      end
    end
    context '編集画面' do
      before do
        visit edit_user_path(other_user)
      end
      it '遷移できずログイン画面に戻る' do
        expect(current_path).to eq('/users/sign_in')
      end
    end
    context '投稿詳細画面' do
      before do
        visit book_path(other_book)
      end
      it '編集ボタンが表示されない' do
        expect(page).not_to have_link '', href: edit_book_path(other_book)
      end

      it '削除ボタンが表示されない' do
        expect(page).not_to have_link '', href: edit_book_path(other_book)
      end
    end
  end

end