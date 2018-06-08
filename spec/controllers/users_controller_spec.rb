require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    let(:user) { create(:user) }

    before { get :index }
    it { expect(response).to have_http_status(:success) }
  end

  describe "#show" do
    let(:user) { create(:user) }

    before { get :show, params: { id: user.id } }
    it { expect(response).to have_http_status(:success) }
  end

  describe "#new" do
    let(:user) { create(:user) }
    
    before { get :new }
    it { expect(response).to have_http_status(:success) }
  end

  describe "#edit" do
    let(:user) { create(:user) }

    before { get :edit, params: { id: user.id } }
    it { expect(response).to have_http_status(:success) }
  end

  describe "#create" do
    context "with valid params" do
      let(:user) { build(:user) }
      let(:valid_attribute) { { name: user.name, email: user.email, password_digest: user.password_digest } }

      it "creates a new User" do
        expect {
          post :create, params: { user: valid_attribute }
        }.to change { User.count }.from(0).to(1)

        expect(response).to redirect_to(User.last)
      end
    end

    context "with invalid params" do
      let(:user) { build(:user) }
      let(:invalid_attribute) { { name: "", email: user.email, password_digest: user.password_digest } }

      before { post :create, params: { user: invalid_attribute } }
      it { expect(response).to be_success }
    end
  end
end
