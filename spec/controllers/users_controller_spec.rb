require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    subject { get :index }

    let(:user) { create(:user) }

    context 'ログインしている時' do
      before { allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(true) }

      it do
        is_expected.to have_http_status(:ok)
        expect(assigns(:users)).to contain_exactly user
      end
    end

    context 'ログインしていない時' do
      before { allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(false) }

      it { is_expected.to redirect_to root_path }
    end
  end

  describe "#show" do
    subject { get :show, params: { id: user.id } }

    let(:user) { create(:user) }

    it do
      is_expected.to have_http_status(:ok)
      expect(assigns(:user)).to eq user
    end
  end

  describe "#new" do
    subject { get :new }

    it do
      is_expected.to have_http_status(:ok)
      expect(assigns(:user).class).to eq User
    end
  end

  describe "#edit" do
    subject { get :edit, params: { id: user.id } }

    let(:user) { create(:user) }

    it do
      is_expected.to have_http_status(:ok)
      expect(assigns(:user)).to eq user
    end
  end

  describe "#create" do
    subject { proc { post :create, params: { user: user_params } } }

    context "with valid params" do
      let(:user_params) { attributes_for :user }

      it "creates a new User" do
        is_expected.to change { User.count }.from(0).to(1)
        expect(response).to redirect_to(User.last)
      end
    end

    context "with invalid params" do
      let(:user_params) { attributes_for :user, name: "" }

      it do
        is_expected.not_to change { User.count }
        expect(response).to render_template :new
      end
    end
  end

  describe "#update" do
    subject { proc { put :update, params: { id: user.id, user: user_params } } }

    let!(:user) { create(:user) }

    context 'with valid params' do
      let(:user_params) { attributes_for :user, name: another_name }

      let(:current_name) { user.name }
      let(:another_name) { "foo" }

      it 'redirects to user page' do
        is_expected.to change { user.reload.name }.from(current_name).to(another_name)
        expect(response).to redirect_to user
      end
    end

    context 'with invalid prams' do
      let(:user_params) { attributes_for :user, name: another_name }

      let(:another_name) { "" }

      it 'redirects to user page' do
        is_expected.to_not change { user.reload.name }
        expect(response).to render_template :edit
      end
    end
  end

  describe "#destroy" do
    subject { proc { delete :destroy, params: { id: user.id } } }

    let!(:user) { create(:user) }

    it "destroy a user" do
      is_expected.to change { User.count }.from(1).to(0)
      expect(response).to redirect_to users_url
    end
  end
end
