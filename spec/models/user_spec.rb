# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password',
      nickname: 'testuser'
    )
  end

  # Eメール、パスワード、ニックネームが有効な状態であること
  it 'is valid with a email, password, and nickname' do
    expect(subject).to be_valid
  end

  # Eメールがなければ無効な状態であること
  it 'is invalid without an email address' do
    subject.email = nil
    expect(subject).to be_invalid
  end

  # パスワードがなければ無効な状態であること
  it 'is invalid without a password' do
    subject.password = nil
    expect(subject).to be_invalid
  end

  # 確認のパスワードが一致しなければ無効な状態であること
  it 'is invalid with a mismatched password' do
    subject.password_confirmation = 'pussword'
    expect(subject).to be_invalid
  end

  # 重複したニックネームは無効な状態であること
  it 'is invalid with a duplicate nickname' do
    described_class.create!(
      email: 'test2@example.com',
      password: 'password',
      password_confirmation: 'password',
      nickname: 'testuser'
    )

    expect(subject).to be_invalid
  end
end
