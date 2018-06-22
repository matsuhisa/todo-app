require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  describe "#index" do
    subject { get :index }

    context 'ユーザーがログインしている時' do
      before { session[:user_id] = user.id }

      let(:user) { create :user }
      let(:team) { create(:team) }

      it do
        is_expected.to have_http_status(:ok)
        expect(assigns(:teams)).to contain_exactly team
      end
    end

    context 'ユーザーがログインしていない時' do
      it { is_expected.to redirect_to root_path }
    end
  end

  describe "#show" do
    subject { get :show, params: { id: team_id } }

    context 'ユーザーがログインしている時' do
      before { session[:user_id] = user.id }

      let(:user) { create :user }

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

    context 'ユーザーがログインしていない時' do
      let(:team) { create(:team) }
      let(:team_id) { team.id }

      it { is_expected.to redirect_to root_path }
    end
  end

  describe "#new" do
    subject { get :new }

    context 'ユーザーがログインしている時' do
      before { session[:user_id] = user.id }

      let(:user) { create :user }

      it do
        is_expected.to have_http_status(:ok)
        expect(assigns(:team).class).to eq Team
      end
    end

    context 'ユーザーがログインしていない時' do
      it { is_expected.to redirect_to root_path }
    end
  end

  describe "#edit" do
    subject { get :edit, params: { id: team_id } }

    context 'ユーザーがログインしている時' do
      before { session[:user_id] = user.id }

      let(:user) { create :user }

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

    context 'ユーザーがログインしていない時' do
      let(:team) { create(:team) }
      let(:team_id) { team.id }

      it { is_expected.to redirect_to root_path }
    end
  end

  describe "#create" do
    subject { post :create, params: { team: team_params } }

    context 'ユーザーがログインしている時' do
      before { session[:user_id] = user.id }

      let(:user) { create :user }

      context "with valid params" do
        let(:team_params) { attributes_for :team }

        it "creates a new Team" do
          expect{ subject }.to change { Team.count }.from(0).to(1)
          is_expected.to redirect_to(Team.last)
        end
      end

      context "with invalid params" do
        let(:team_params) { attributes_for :team, name: "" }

        it do
          expect{ subject }.not_to change { Team.count }
          is_expected.to render_template :new
        end
      end
    end

    context 'ユーザーがログインしていない時' do
      let(:team_params) { attributes_for :team }

      it { is_expected.to redirect_to root_path }
    end
  end

  describe "#update" do
    subject { put :update, params: { id: team.id, team: team_params } }

    let(:team) { create(:team) }

    context 'ユーザーがログインしている時' do
      before { session[:user_id] = user.id }

      let(:user) { create :user }
      let(:team_params) { attributes_for :team, name: another_name }

      context 'with valid params' do
        let(:another_name) { "みんなのウェディングチーム" }

        it 'redirects to team page' do
          expect{ subject }.to change { team.reload.name }.to(another_name)
          is_expected.to redirect_to team
        end
      end

      context 'with invalid prams' do
        let(:another_name) { "" }

        it 'render to team editting page' do
          expect{ subject }.to_not change { team.reload.name }
          is_expected.to render_template :edit
        end
      end
    end

    context 'ユーザーがログインしていない時' do
      let(:team_params) { attributes_for :team }

      it { is_expected.to redirect_to root_path }
    end
  end
end
