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
<<<<<<< HEAD
    end
=======
     end
>>>>>>> Add rspec test of #update and #destroy
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
<<<<<<< HEAD

      it do
        is_expected.not_to change { User.count }
        expect(response).to render_template :new
      end
=======

      it do
        is_expected.not_to change { User.count }
        expect(response).to render_template :new
      end
    end
  end

  describe "#update" do
    let(:user) { create(:user) }

    context 'with valid params' do
      before { put :update, params: { id: user.id, user: { id: user.id, name: "foo" } } }

      it 'redirects to user page' do
        expect(assigns(:user).name).to eq "foo"
        expect(response).to redirect_to user
      end
    end

    context 'with invalid prams' do
      before { put :update, params: { id: user.id, user: { id: user.id, name: "" } } }

      it 'redirects to user page' do
        expect(response).to render_template :edit
      end
    end
  end

  describe "#destroy" do
    subject { proc { delete :destroy, params: { id: @user } } }

    before do
      @user = create(:user)
    end

    it "destroy a user" do
      is_expected.to change { User.count }.from(1).to(0)
      expect(response).to redirect_to users_url
>>>>>>> Add rspec test of #update and #destroy
    end
  end
end
