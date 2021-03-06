require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:user) { create(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ""
        is_expected.to eq false
      end

      it '1文字以下でないこと' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end

      it '2文字以上であること' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end

      it '21文字以上でないこと' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end

      it '20文字以下であること' do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end

    end
    context 'introductionカラム' do
      it '50文字以内であること' do
        user.introduction = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

  end
end