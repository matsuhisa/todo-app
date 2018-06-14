require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    subject { build :user, attributes }

    context 'name, email, passwordがvalidなとき' do
      let(:attributes) { {} }

      it { is_expected.to be_valid }
    end

    context 'nameが存在しないとき' do
      let(:attributes) { { name: "" } }

      it { is_expected.to be_invalid }
    end

    context 'emailが存在しないとき' do
      let(:attributes) { { email: "" } }

      it { is_expected.to be_invalid }
    end

    context 'emailが正しくないとき' do
      let(:attributes) { { email: "test@example" } }

      it { is_expected.to be_invalid }
    end

    context 'passwordが6文字のとき' do
      let(:attributes) { { password: "a" * 6, password_confirmation: "a" * 6 } }

      it { is_expected.to be_valid }
    end

    context 'passwordが5文字のとき' do
      let(:attributes) { { password: "a" * 5, password_confirmation: "a" * 5 } }

      it { is_expected.to be_invalid }
    end

    context 'emailが正しくないとき' do
      let(:user) { build(:user, email: "test@example") }

      it { expect(user).to be_invalid }
    end

    context 'passwordが6文字のとき' do
      let(:user) { build(:user, password: "aaaaaa", password_confirmation: "aaaaaa") }

      it { expect(user).to be_valid }
    end

    context 'passwordが5文字のとき' do
      let(:user) { build(:user, password: "aaaaa", password_confirmation: "aaaaa") }

      it { expect(user).to be_invalid }
    end
  end
end
