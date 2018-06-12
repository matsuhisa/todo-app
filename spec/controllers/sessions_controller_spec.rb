require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "#new" do
    subject { get :new }

    it { is_expected.to have_http_status(:success) }
  end

  describe "#create" do
    subject { post :create, params: { session: user_params } }
    let!(:user) { create(:user) }

    context 'emailとpasswordが有効なとき' do
      let(:user_params) { { email: user.email, password: user.password } }

      it { is_expected.to redirect_to user }
    end

    context 'emailが無効なとき' do
      let(:user_params) { { email: 'test@example.com', password: user.password } }

      it { is_expected.to render_template :new }
    end

    context 'passwordが無効なとき' do
      let(:user_params) { { email: user.email, password: 'foobar' } }

      it { is_expected.to render_template :new }
    end
  end
end
