require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#valid?' do
    subject { build :task, attributes }

    context 'タスクの登録に成功するとき' do
      let(:attributes) { {} }

      it { is_expected.to be_valid }
    end
  end
end
