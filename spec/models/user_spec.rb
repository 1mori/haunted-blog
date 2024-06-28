# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Eメール、パスワード、ニックネームがある場合' do
    user = FactoryBot.build(:user)

    it '作成が有効であること' do
      expect(user.valid?).to be true
    end
  end

  context 'Eメールがない場合' do
    user = FactoryBot.build(:user, email: nil)

    it '作成は無効であること' do
      expect(user.valid?).to be false
    end
  end

  context 'パスワードがない場合' do
    user = FactoryBot.build(:user, password: nil)

    it '作成は無効であること' do
      expect(user.valid?).to be false
    end
  end

  context '確認のパスワードが一致しない場合' do
    user = FactoryBot.build(:user, password_confirmation: 'wrong_password')

    it '作成は無効であること' do
      expect(user.valid?).to be false
    end
  end

  context '2人以上のユーザーが存在する場合' do
    duplicated_nickname_user = FactoryBot.build(:user, email: 'test2@example.com')

    before do
      FactoryBot.create(:user)
    end

    it '重複したニックネームは無効であること' do
      expect(duplicated_nickname_user.valid?).to be false
    end
  end
end
