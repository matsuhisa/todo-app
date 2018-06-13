require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'nameとemailに正しい入力がされたとき' do
      let(:user) { build(:user) }

      it { expect(user).to be_valid }
    end

    context 'nameが空のとき' do
      let(:user) { build(:user, name: "") }

      it { expect(user).to be_invalid }
    end

    context 'emailが空のとき' do
      let(:user) { build(:user, email: "") }

      it { expect(user).to be_invalid }
    end
  end
end
