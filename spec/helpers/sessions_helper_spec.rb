require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe '#login' do
    let(:user) { create(:user) }
    subject { helper.log_in(user) }

    it { is_expected.to eq user.id }
  end

  describe '#current_user' do
      let(:user) { create(:user) }
      subject { helper.current_user }

    context 'ログインユーザーがいる場合' do
      before { helper.log_in(user) }

      it { is_expected.to eq user }
    end
    context 'ログインユーザーがいない場合' do
      it { is_expected.to be_nil }
    end
  end

  describe '#logged_in' do
    let(:user) { create(:user) }
    subject { helper.logged_in? }

    context 'current_userがいる時' do
      before { helper.log_in(user) }

      it { is_expected.to be_truthy }
    end

    context 'current_userがnilの時' do
      it { is_expected.to be_falsey }
    end
  end

  describe '#log_out' do
    let(:user) { create(:user) }
    subject { helper.log_out }

    before {
      helper.log_in(user)
      helper.log_out
    }

    it {
      expect(session[:user_id]).to be_nil
      is_expected.to be_nil
    }
  end
end
