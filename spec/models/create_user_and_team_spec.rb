require 'rails_helper'

RSpec.describe CreateUserAndTeam, type: :model do
  describe '#save' do
    let(:user) { build :user, attributes }

    context '保存に成功したとき' do
      let(:attributes) { {} }
      let(:decorator) { CreateUserAndTeam.new(user) }

      it { expect(decorator.save).to be_truthy }
    end

    context '保存に失敗したとき' do
      let(:attributes) { { name: "" } }
      let(:decorator) { CreateUserAndTeam.new(user) }

      it { expect(decorator.save).to be_falsey }
    end
  end
end
