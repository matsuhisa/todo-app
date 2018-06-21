require 'rails_helper'

RSpec.describe CreateUserDecorator, type: :model do
  describe '#save' do
    subject { proc { user_with_team_create.save } }

    let(:user) { build :user, attributes }
    let(:user_with_team_create) { CreateUserDecorator.new(user: user) }

    context 'ユーザの保存とチームの保存に成功したとき' do
      let(:attributes) { {} }

      it do
        is_expected.to be_truthy
        is_expected.to change { Team.count }.from(0).to(1).and \
          change { User.count }.from(0).to(1).and \
          change { UserTeam.count }.from(0).to(1)
      end
    end

    context 'チームの保存に失敗したとき' do

      # it { is_expected.to be_falsey }
    end

    context 'ユーザの保存に失敗したとき' do
      let(:attributes) { { name: "" } }

      it do
        is_expected.not_to change { User.count }
        is_expected.not_to change { Team.count }
        is_expected.not_to change { UserTeam.count }
      end
    end
  end
end
