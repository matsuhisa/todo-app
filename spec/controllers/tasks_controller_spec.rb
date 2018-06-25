require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }

  describe "#index" do
    subject { get :index }

    let(:user) { create(:user) }
    let(:task) { create(:task) }

    before { log_in user }

    it do
      is_expected.to have_http_status(:ok)
      expect(assigns(:tasks)).to contain_exactly task
    end

    context 'ログインしていない時' do
      it { is_expected.to redirect_to root_path }
    end

  end

  describe "#show" do
    subject { get :show, params: { id: task_id } }

    let(:user) { create(:user) }

    before { log_in user }

    context 'when id is valid' do
      let(:task) { create(:task) }
      let(:task_id) { task.id }

    context 'ログインしている時' do
      before { log_in user }

      context 'when id is valid' do
        it do
          is_expected.to have_http_status(:ok)
          expect(assigns(:task)).to eq task
        end
      end

      context 'when id is invalid' do
        let(:task_id) { 'aaa' }

        it { expect{subject}.to raise_error ActiveRecord::RecordNotFound }
      end
    end

    context 'ログインしていない時' do
      it { is_expected.to redirect_to root_path }
    end
  end

  describe "#new" do
    subject { get :new }

    let(:user) { create(:user) }

    before { log_in user }

    it do
      is_expected.to have_http_status(:ok)
      expect(assigns(:task).class).to eq Task
    end
  end

  describe "#create" do
    subject { post :create, params: { task: task_params } }

    let(:user) { create(:user) }

    before { log_in user }

    context "with valid params" do
      let(:task_params) { attributes_for :task }

    context 'ログインしている時' do
      before { log_in user }

      context "with valid params" do
        it "creates a new task" do
          expect{ subject }.to change { Task.count }.by(1)
          is_expected.to redirect_to(Task.last)
        end
      end

      context "with invalid params" do
        let(:task_params) { attributes_for :task, title: "" }

        it do
          expect{ subject }.not_to change { Task.count }
          is_expected.to render_template :new
        end
      end
    end

    context 'ログインしていない時' do
      it { is_expected.to redirect_to root_path }
    end
  end
end
