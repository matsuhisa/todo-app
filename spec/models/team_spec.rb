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

    context 'nameが101文字の時' do
      let(:attributes) { { name: "a" * 101 } }

      it { is_expected.to be_invalid }
    end

    context 'nameが100文字の時' do
      let(:attributes) { { name: "a" * 100 } }

      it { is_expected.to be_valid }
    end

    context 'nameが99文字の時' do
      let(:attributes) { { name: "a" * 99 } }

      it { is_expected.to be_valid }
    end

    context 'colorが入力されてない時' do
      let(:attributes) { { color: "" } }

      it { is_expected.to be_invalid }
    end

    context 'カラーコードがテキストな時' do
      let(:attributes) { { color: "white" } }

      it { is_expected.to be_invalid }
    end

    context 'カラーコードが不正な時' do
      let(:attributes) { { color: "#fffffff" } }

      it { is_expected.to be_invalid }
    end
  end
end
