require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "#index" do
    subject { get :index }

    let(:task) { create(:task) }

    it do
      is_expected.to have_http_status(:ok)
      expect(assigns(:tasks)).to contain_exactly task
    end
  end

  describe "#show" do
    subject { get :show, params: { id: task_id } }

    context 'when id is valid' do
      let(:task) { create(:task) }
      let(:task_id) { task.id }

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

  describe "#new" do
    subject { get :new }

    it do
      is_expected.to have_http_status(:ok)
      expect(assigns(:task).class).to eq task
    end
  end

  describe "#create" do
    subject { proc { post :create, params: { task: task_params } } }

    context "with valid params" do
      let(:task_params) { attributes_for :task }

      it "creates a new task" do
        is_expected.to change { task.count }.from(0).to(1)
        expect(response).to redirect_to(task.last)
      end
    end

    context "with invalid params" do
      let(:task_params) { attributes_for :task, title: "" }

      it do
        is_expected.not_to change { task.count }
        expect(response).to render_template :new
      end
    end
  end
end
