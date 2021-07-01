require 'rails_helper'

RSpec.describe '仕上げのテスト' do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:book) { create(:book) }
  let!(:other_book) { create(:book)}

  describe '他人の画面へのアクセス制限のテスト' do
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

  describe 'フラッシュメッセージのテスト' do
    context 'ログイン後' do
      before do
        visit new_user_session_path
        fill_in 'user[name]', with: user.name
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end
      it '正しいメッセージが表示される' do
        expect(page).to have_content 'successfully'
      end
    end
    context 'サインアップ後' do
      before do
        visit new_user_registration_path
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        password = Faker::Internet.password(min_length: 6)
        fill_in 'user[password]', with: password
        fill_in 'user[password_confirmation]', with: password
        click_button 'Sign up'
      end
      it '正しいメッセージが表示される' do
        expect(page).to have_content 'successfully'
      end
    end
    context 'ログアウト後' do
      before do
        visit new_user_session_path
        fill_in 'user[name]', with: user.name
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        click_link 'logout'
      end
      it '正しいメッセージが表示される' do
        expect(page).to have_content 'successfully'
      end
    end
    context 'ユーザー編集後' do
      before do
        visit edit_user_path(user)
        click_link 'Update User'
      end
      it '正しいメッセージが表示される' do
        expect(page).to have_content 'successfully'
      end
    end
    context '投稿編集後' do
      before do
        visit edit_book_path(book)
        find('.form-group').click
      end
      it '正しいメッセージが表示される' do
        expect(page).to have_content 'successfully'
      end
    end
  end

end