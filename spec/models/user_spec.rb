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

  it 'Eメール、パスワード、ニックネームが有効であること' do
    expect(subject).to be_valid
  end

  it 'Eメールがなければ無効であること' do
    subject.email = nil
    expect(subject).to be_invalid
  end

  it 'パスワードがなければ無効であること' do
    subject.password = nil
    expect(subject).to be_invalid
  end

  it '確認のパスワードが一致しなければ無効であること' do
    subject.password_confirmation = 'pussword'
    expect(subject).to be_invalid
  end

  it '重複したニックネームは無効であること' do
    described_class.create!(
      email: 'test2@example.com',
      password: 'password',
      password_confirmation: 'password',
      nickname: 'testuser'
    )

    expect(subject).to be_invalid
  end
end
