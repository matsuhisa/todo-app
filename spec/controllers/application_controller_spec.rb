require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      @current_user = current_user
      head :nothing
    end
  end

  describe '#current_user' do
    let!(:user) { create(:user) }

    context 'ログインユーザーがいる場合' do
      before do
        @current_user = user
        get :index
      end

      it { expect(assigns(:current_user)).to eq user }
    end

    context 'ログインユーザーがいない場合' do
      before do
        get :index
      end

      it { expect(assigns(:current_user)).to be_nil }
    end
  end

  describe '#logged_in?' do
    subject { controller.send(:logged_in?) }

    let(:user) { create(:user) }

    context 'current_userがいる時' do
      before do
        session[:user_id] = user.id
      end

      it { is_expected.to be_truthy }
    end

    context 'current_userがnilの時' do
      it { is_expected.to be_falsey }
    end
  end
end
