require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) { { name: "mwed", email: "test@example.com", password_digest: "hoge" } }
  let(:invalid_attributes) { { name: "", email: "test@example.com", password_digest: "hoge" } }

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

      it "creates a new User" do
        expect {
          post :create, params: { user: { name: user.name, email: user.email, password_digest: user.password_digest } }
        }.to change { User.count }.from(0).to(1)

        expect(response).to redirect_to(User.last)
      end
    end

    context "with invalid params" do
      let(:user) { build(:user) }

      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { user: { name: "", email: user.email, password_digest: user.password_digest } }
        expect(response).to be_success
      end
    end
  end
end
