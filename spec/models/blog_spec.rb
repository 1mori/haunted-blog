# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Blog, type: :model do
  context 'タイトル、本文、公開・非公開の設定がある場合' do
    let(:blog) { build(:blog) }

    it '作成が有効であること' do
      expect(blog.valid?).to be true
    end
  end
end
