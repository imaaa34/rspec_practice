require 'rails_helper'

RSpec.describe 'ログイン後のテスト' do
  let!(:user) { create(:user) }
  let!(:book) { create(:book) }

  before do
    visit new_user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe 'ログイン成功時' do
    it '画面遷移が正しい' do
      visit user_path(user)
    end
  end

  describe 'ログイン失敗時' do
    it'画面遷移が正しい' do
      visit new_user_session_path
    end
  end

  describe 'サインアップ成功時' do
    it '画面遷移が正しい' do
      visit user_path(user)
    end
  end

  describe 'サインアップ失敗時' do
    it '画面遷移が正しい' do
      visit new_user_registration_path
    end

    it 'nameエラーメッセージが表示される' do
      user.name = ""
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("is too short (minimum is 2 characters)")
    end

    it 'emailエラーメッセージが表示される' do
      user.email = ""
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'passwordエラーメッセージが表示される' do
      user.password = ""
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("can't be blank")
    end
  end

  describe 'ログイン後のヘッダーのテスト' do
    it 'Users画面へのリンクが表示されている' do
      expect(page).to have_link 'Users'
      click_link 'Users'
      expect(current_path).to eq '/users'
    end

    it 'Books画面へのリンクが表示されている' do
      expect(page).to have_link 'Books'
      click_link 'Books'
      expect(current_path).to eq '/books'
    end

    it 'ログアウトへのリンクが表示されている' do
      expect(page).to have_link 'logout'
    end
  end

  describe 'ログイン後のサイドバーのテスト' do
    it '名前と紹介文が表示されている' do
      expect(page).to have_content user.name
      expect(page).to have_content user.introduction
    end

    it '自分のユーザー編集画面へのリンクが表示されている' do
      expect(page).to have_link '', href: edit_user_path(user)
    end

    it 'title新規投稿入力フォームが表示されている' do
      expect(page).to have_field 'book[title]'
    end

    it 'body新規投稿入力フォームが表示されている' do
      expect(page).to have_field 'book[body]'
    end

    it 'titleエラーメッセージが表示される' do
      book.title = ""
      expect(book).to be_invalid
      expect(book.errors[:title]).to include("can't be blank")
    end

    it 'bodyエラーメッセージが表示される' do
      book.body = ""
      expect(book).to be_invalid
      expect(book.errors[:body]).to include("can't be blank")
    end
  end

  describe 'ユーザー編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'name編集フォームが表示されている' do
        expect(page).to have_field 'user[name]', with: user.name
      end

      it 'introduction編集フォームが表示されている' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end

      it 'Update Userボタンが表示されている' do
        expect(page).to have_button 'Update User'
      end
    end

    context '編集成功時' do
      it '画面遷移が正しい' do
        visit user_path(user)
      end
    end

    context '編集失敗時' do
      it 'nameエラーメッセージが表示される' do
        user.name = ""
        expect(user).to be_invalid
        expect(user.errors[:name]).to include("is too short (minimum is 2 characters)")
      end
    end
  end

  describe '新規投稿のテスト' do
    before do
      fill_in 'book[title]', with: Faker::Lorem.characters(number: 5)
      fill_in 'book[body]', with: Faker::Lorem.characters(number: 15)
    end

    it '新規投稿が保存される' do
      expect { click_button 'Create Book'}.to change(user.books, :count).by(1)
    end
  end

  describe 'ログアウト成功時' do
    it '画面遷移が正しい' do
      click_link 'logout'
      visit root_path
    end
  end

end