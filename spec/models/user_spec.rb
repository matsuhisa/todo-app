require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'name, email, passwordがvalidなとき' do
      let(:user) { build(:user) }

      it { expect(user).to be_valid }
    end

    context 'nameが存在しないとき' do
      let(:user) { build(:user, name: "") }

      it { expect(user).to be_invalid }
    end

    context 'emailが存在しないとき' do
      let(:user) { build(:user, email: "") }

      it { expect(user).to be_invalid }
    end

    context 'emailが正しくないとき' do
      let(:user) { build(:user, email: "test@example") }

      it { expect(user).to be_invalid }
    end

    context 'passwordが6文字のとき' do
      subject { build :user, attributes }

      let(:attributes) { { password: "a" * 6, password_confirmation: "a" * 6 } }

      it { is_expected.to be_valid }
    end

    context 'passwordが5文字のとき' do
      subject { build :user, attributes }

      let(:attributes) { { password: "a" * 5, password_confirmation: "a" * 5 } }

      it { is_expected.to be_invalid }
    end
  end
end
