require 'rails_helper'

RSpec.describe Team, type: :model do
  describe '#valid?' do
    subject { build :team, attributes }

    context 'name, colorがvalidな時' do
      let(:attributes) { {} }

      it { is_expected.to be_valid }
    end

    context 'nameが入力されてない時' do
      let(:attributes) { { name: "" } }

      it { is_expected.to be_invalid }
    end

    context 'colorが入力されてない時' do
      let(:attributes) { { color: "" } }

      it { is_expected.to be_invalid }
    end
  end
end
