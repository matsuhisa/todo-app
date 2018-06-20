require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe '#login' do
    subject { proc { helper.log_in(user) } }

    let(:user) { create(:user) }

    it { is_expected.to change { session[:user_id] }.from(nil).to(user.id) }
  end

  describe '#log_out' do
    let(:user) { create(:user) }

    before { helper.log_in(user) }

    it do
      expect(proc { helper.log_out }).to change { session[:user_id] }.from(user.id).to(nil).and \
        change { current_user }.to(nil)
    end
  end
end
