require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    let(:user) { create(:user) }

    subject { get :index }

    it do
      is_expected.to have_http_status(:success)
      expect(assigns(:users)).to contain_exactly user
    end
  end

  describe "#show" do
    let(:user) { create(:user) }

    subject { get :show, params: { id: user.id } }

    it do
      is_expected.to have_http_status(:success)
      expect(assigns(:user)).to eq user
    end
  end

  describe "#new" do
    subject { get :new }

    it do
      is_expected.to have_http_status(:success)
      expect(assigns(:user).class).to eq User
    end
  end

  describe "#edit" do
    let(:user) { create(:user) }

    subject { get :edit, params: { id: user.id } }

    it do
      is_expected.to have_http_status(:success)
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
end
