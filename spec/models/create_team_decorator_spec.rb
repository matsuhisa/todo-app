require 'rails_helper'

RSpec.describe CreateTeamDecorator, type: :model do
  describe '#save' do
    let(:user) { build :user, attributes }
    let(:user_with_team_create) { CreateTeamDecorator.new(user: user) }

    context 'ユーザの保存とチームの保存に成功したとき' do
      subject { proc { user_with_team_create.save } }

      let(:attributes) { {} }

      it do
        is_expected.to be_truthy
        is_expected.to change { Team.count }.by(1).and \
          change { User.count }.by(1).and \
          change { UserTeam.count }.by(1)
      end
    end

    context 'チームの保存に失敗したとき' do
      subject { user_with_team_create.save }

      let(:attributes) { {} }

      before { allow_any_instance_of(Team).to receive(:save!).and_raise() }

      it { is_expected.to be_falsey }
    end

    context 'ユーザの保存に失敗したとき' do
      subject { proc { user_with_team_create.save } }

      let(:attributes) { { name: "" } }

      it do
        is_expected.not_to change { User.count }
        is_expected.not_to change { Team.count }
        is_expected.not_to change { UserTeam.count }
      end
    end
  end
end
