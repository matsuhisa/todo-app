require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe '#login' do
    subject { helper.log_in(user) }

    let(:user) { create(:user) }

    it { is_expected.to eq user.id }
  end

  describe '#current_user' do
    subject { helper.current_user }

    let(:user) { create(:user) }

    context 'ログインユーザーがいる場合' do
      before { helper.log_in(user) }

      it { is_expected.to eq user }
    end
    context 'ログインユーザーがいない場合' do
      it { is_expected.to be_nil }
    end
  end

  describe '#logged_in' do
    subject { helper.logged_in? }

    let(:user) { create(:user) }

    context 'current_userがいる時' do
      before { helper.log_in(user) }

      it { is_expected.to be_truthy }
    end

    context 'current_userがnilの時' do
      it { is_expected.to be_falsey }
    end
  end

  describe '#log_out' do
    subject { helper.log_out }

    let(:user) { create(:user) }

    before do
      helper.log_in(user)
      helper.log_out
    end

    it {
      expect(session[:user_id]).to be_nil
      is_expected.to be_nil
    }
  end
end
