require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  describe "#index" do
    subject { get :index }

    let(:team) { create(:team) }

    it do
      is_expected.to have_http_status(:ok)
      expect(assigns(:teams)).to contain_exactly team
    end
  end

  describe "#show" do
    subject { get :show, params: { id: team_id } }

    context 'when id is valid' do
      let(:team) { create(:team) }
      let(:team_id) { team.id }

      it do
        is_expected.to have_http_status(:ok)
        expect(assigns(:team)).to eq team
      end
    end

    context 'when id is invalid' do
      let(:team_id) { 'aaa' }

      it { expect{subject}.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe "#new" do
    subject { get :new }

    it do
      is_expected.to have_http_status(:ok)
      expect(assigns(:team).class).to eq Team
    end
  end

  describe "#edit" do
    subject { get :edit, params: { id: team_id } }

    context 'when id is valid' do
      let(:team) { create(:team) }
      let(:team_id) { team.id }

      it do
        is_expected.to have_http_status(:ok)
        expect(assigns(:team)).to eq team
      end
    end

    context 'when id is invalid' do
      let(:team_id) { 'aaa' }

      it { expect{subject}.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe "#create" do
    subject { proc { post :create, params: { team: team_params } } }

    context "with valid params" do
      let(:team_params) { attributes_for :team }

      it "creates a new Team" do
        is_expected.to change { Team.count }.from(0).to(1)
        expect(response).to redirect_to(Team.last)
      end
    end

    context "with invalid params" do
      let(:team_params) { attributes_for :team, name: "" }

      it do
        is_expected.not_to change { Team.count }
        expect(response).to render_template :new
      end
    end
  end

  describe "#update" do
    subject { proc { put :update, params: { id: team.id, team: team_params } } }

    let!(:team) { create(:team) }

    context 'with valid params' do
      let(:team_params) { attributes_for :team, name: another_name }

      let(:current_name) { team.name }
      let(:another_name) { "みんなのウェディング" }

      it 'redirects to team page' do
        is_expected.to change { team.reload.name }.from(current_name).to(another_name)
        expect(response).to redirect_to team
      end
    end

    context 'with invalid prams' do
      let(:team_params) { attributes_for :team, name: another_name }

      let(:another_name) { "" }

      it 'render to team editting page' do
        is_expected.to_not change { team.reload.name }
        expect(response).to render_template :edit
      end
    end
  end
end
