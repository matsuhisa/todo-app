require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  # let(:user) { create(:user) }

  describe "#index" do
    subject { get :index }

    context 'ログインしている時' do
      let(:task) { create(:task, :with_user_and_team) }

      before do
        log_in task.user
      end

      it do
        is_expected.to have_http_status(:ok)
        expect(assigns(:tasks)).to contain_exactly task
      end
    end

    context 'ログインしていない時' do
      it { is_expected.to redirect_to root_path }
    end
  end

  describe "#show" do
    subject { get :show, params: { id: task_id } }

    let(:task) { create(:task, :with_user_and_team) }
    let(:task_id) { task.id }

    before do
      log_in task.user
    end

    context 'when id is valid' do
      it do
        is_expected.to have_http_status(:ok)
        expect(assigns(:task)).to eq task
      end
    end

    context 'when id is invalid' do
    let(:task_id) { 'aaa' }

    it { expect { subject }.to raise_error ActiveRecord::RecordNotFound }
  end
  end

  describe "#new" do
    subject { get :new }

    let(:user) { create(:user, teams: create_list(:team, 2)) }

    before { log_in user }

    it do
      is_expected.to have_http_status(:ok)
      expect(assigns(:task).class).to eq Task
      expect(assigns(:teams)).to eq user.teams
    end
  end

  describe "#create" do
    subject { post :create, params: { task: task_params } }

    let(:user) { create(:user) }
    let!(:team) { create(:team, users: [user]) }
    let(:task_params) { attributes_for :task, team_id: team.id }

    context 'ログインしている時' do
      before { log_in user }

      context "with valid params" do
        it "creates a new task" do
          aggregate_failures do
            expect { subject }.to change { Task.count }.by(1)
            expect(response).to redirect_to(Task.last)
            expect(assigns(:task).user_id).to eq user.id
          end
        end
      end

      context "with invalid params" do
        let(:task_params) { attributes_for :task, team_id: team.id, title: "" }

        it do
          expect { subject }.not_to change { Task.count }
          expect(response).to render_template :new
          expect(assigns(:task).user_id).to eq user.id
        end
      end
    end

    context 'ログインしていない時' do
      it { is_expected.to redirect_to root_path }
    end
  end
end
