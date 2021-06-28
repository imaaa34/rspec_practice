require 'rails_helper'

RSpec.describe 'ログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end

      it 'アバウト画面へのリンクが表示されている' do
        expect(page).to have_link 'About'
      end

      it 'ログイン画面へのリンクが表示されている' do
        expect(page).to have_link 'login'
      end

      it 'サインアップ画面へのリンクが表示されている' do
        expect(page).to have_link 'sign up'
      end
    end
  end

  describe 'アバウト画面のテスト' do
    before do
      visit '/home/about'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/home/about'
      end
    end
  end

  describe 'ログイン画面のテスト' do
    before do
      visit '/users/sign_in'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end

      it 'name入力フォームが表示されている' do
        expect(page).to have_field 'user[name]'
      end

      it 'password入力フォームが表示されている' do
        expect(page).to have_field 'user[password]'
      end

      it 'email入力フォームが表示されていない' do
        expect(page).not_to have_field 'user[email]'
      end
    end
  end

  describe 'サインアップ画面のテスト' do
    before do
      visit '/users/sign_up'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end

      it 'name入力フォームが表示されている' do
        expect(page).to have_field 'user[name]'
      end

      it 'email入力フォームが表示されている' do
        expect(page).to have_field 'user[email]'
      end

      it 'password入力フォームが表示されている' do
        expect(page).to have_field 'user[password]'
      end

      it 'password確認入力フォームが表示されている' do
        expect(page).to have_field 'user[password_confirmation]'
      end
    end
  end
end