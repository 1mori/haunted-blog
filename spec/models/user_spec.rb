# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'ユーザー登録をする場合' do
    let(:correct_user) { described_class.new(email: 'test@example.com', password: 'password', password_confirmation: 'password', nickname: 'testuser') }
    let(:incorrect_email_user) { described_class.new(email: nil, password: 'password', password_confirmation: 'password', nickname: 'testuser') }
    let(:incorrect_password_user) { described_class.new(email: 'test@example.com', password: nil, password_confirmation: 'password', nickname: 'testuser') }
    let(:incorrect_confirm_password_user) do
      described_class.new(email: 'test@example.com', password: 'password', password_confirmation: 'wrong_password', nickname: 'testuser')
    end

    it 'Eメール、パスワード、ニックネームが有効であること' do
      expect(correct_user.valid?).to be true
    end

    it 'Eメールがなければ無効であること' do
      expect(incorrect_email_user.valid?).to be false
    end

    it 'パスワードがなければ無効であること' do
      expect(incorrect_password_user.valid?).to be false
    end

    it '確認のパスワードが一致しなければ無効であること' do
      expect(incorrect_confirm_password_user.valid?).to be false
    end
  end

  context '2人以上のユーザーが存在する場合' do
    let(:duplicated_nickname_user) do
      described_class.new(email: 'test2@example.com', password: 'password', password_confirmation: 'password', nickname: 'testuser')
    end

    before do
      described_class.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password', nickname: 'testuser')
    end

    it '重複したニックネームは無効であること' do
      expect(duplicated_nickname_user.valid?).to be false
    end
  end
end
