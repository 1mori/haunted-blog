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
  it 'is invalid without an email address'

  # パスワードがなければ無効な状態であること
  it 'is invalid without a password'

  # ニックネームがなければ無効な状態であること
  it 'is invalid without a nickname'

  # 重複したニックネーは無効な状態であること
  it 'is invalid with a duplicate nickname'
end
