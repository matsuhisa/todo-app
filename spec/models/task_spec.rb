require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#valid?' do
    let(:user) { create(:user) }
    let!(:team) { create(:team, users: [user]) }
    let(:valid_params) { { user_id: user.id, team_id: team.id } }

    subject { build :task, attributes }

    context 'タスクの登録に成功するとき' do
      let(:attributes) { valid_params }

      it { is_expected.to be_valid }
    end

    context 'titleが存在しないとき' do
      let(:attributes) { valid_params.merge(title: '') }

      it { is_expected.to be_invalid }
    end

    context 'titleが100文字のとき' do
      let(:attributes) { valid_params.merge(title: 'a' * 100) }

      it { is_expected.to be_valid }
    end

    context 'titleが101文字のとき' do
      let(:attributes) { valid_params.merge(title: 'a' * 101) }

      it { is_expected.to be_invalid }
    end

    context 'descriptionが存在しないとき' do
      let(:attributes) { valid_params.merge(description: '') }

      it { is_expected.to be_invalid }
    end

    context 'descriptionが10000文字のとき' do
      let(:attributes) { valid_params.merge(description: 'a' * 10000) }

      it { is_expected.to be_valid }
    end

    context 'descriptionが10001文字のとき' do
      let(:attributes) { valid_params.merge(description: 'a' * 10001) }

      it { is_expected.to be_invalid }
    end

    context 'stateが存在しないとき' do
      let(:attributes) { valid_params.merge(state: '') }

      it { is_expected.to be_invalid }
    end
  end
end
