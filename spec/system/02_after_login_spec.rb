require 'rails_helper'

RSpec.describe 'ログイン後のテスト' do
  let!(:user) { create(:user) }

  describe 'ログイン成功時' do
    it '画面遷移が正しい' do
      visit user_path(user)
    end

    # it 'Users画面へのリンクが表示されている' do
    #   expect(page).to have_link 'Users'
    # end

    # it 'Books画面へのリンクが表示されている' do
    #   expect(page).to have_link 'Books'
    # end

    # it 'ログアウトへのリンクが表示されている' do
    #   expect(page).to have_link 'logout'
    # end
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

    # it 'Users画面へのリンクが表示されている' do
    #   expect(page).to have_link 'Users'
    # end

    # it 'Books画面へのリンクが表示されている' do
    #   expect(page).to have_link 'Books'
    # end

    # it 'ログアウトへのリンクが表示されている' do
    #   expect(page).to have_link 'logout'
    # end
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
end