require 'rails_helper'

RSpec.describe 'Bookモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { book.valid? }

    let!(:book) { create(:book) }

    context 'titleカラム' do
      it '空欄でないこと' do
        book.title = ""
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        book.body = ""
        is_expected.to eq false
      end

      it '200文字以内であること' do
        book.body = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end
 end