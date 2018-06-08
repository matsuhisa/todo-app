require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    context 'nameとemailに正しい入力がされたとき' do
      let(:user) { create(:user) }

      it { expect(user.valid?).to eq true }
    end

    context 'nameが空のとき' do
      let(:user) { create(:user, name: "") }

      it { expect(user.valid?).to eq false }
    end

    context 'emailが空のとき' do
      let(:user) { create(:user, email: "") }

      it { expect(user.valid?).to eq false }
    end
  end
end
