require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe '#login' do
    subject { proc { helper.log_in(user) } }

    let(:user) { create(:user) }

    it { is_expected.to change { session[:user_id] }.from(nil).to(user.id) }
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
    let(:user) { create(:user) }

    before do
      helper.log_in(user)
    end

    it {
      expect(proc { helper.log_out }).to change { session[:user_id] }.from(user.id).to(nil).and \
        change { helper.current_user }.to(nil)
    }
  end
end
