require 'rails_helper'

RSpec.describe CreateUserDecorator, type: :model do
  describe '#save' do
    subject { user_with_team_create.save }

    let(:user) { build :user, attributes }
    let(:user_with_team_create) { CreateUserDecorator.new(user: user) }

    context '保存に成功したとき' do
      let(:attributes) { {} }

      it { is_expected.to be_truthy }
    end

    context '保存に失敗したとき' do
      let(:attributes) { { name: "" } }

      it { is_expected.to be_falsey }
    end
  end
end
