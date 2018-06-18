require "rails_helper"

RSpec.describe ColorValidator do
  subject { model_class.new(color).valid? }

  let(:model_class) do
    Class.new do
      include ActiveModel::Validations
      validates :color, color: true

      attr_accessor :color

      def initialize(color)
        @color = color
      end

      def self.name
        "ColorModel"
      end
    end
  end

  context "when color-code with 6 characters is valid" do
    let(:color) { '#2fc3a7' }

    it { is_expected.to be_truthy }
  end

  context "when color-code with 3 characters is valid" do
    let(:color) { '#fff' }

    it { is_expected.to be_truthy }
  end

  context "when color-code is invalid" do
    let(:color) { '#fffffff' }

    it { is_expected.to be_falsey }
  end

  context "when color-code without # is invalid" do
    let(:color) { 'ffffff' }

    it { is_expected.to be_falsey }
  end

  context "when color-code with not allowed characters is invalid" do
    let(:color) { '#TTT' }

    it { is_expected.to be_falsey }
  end

  context "when it's not a color code is invalid" do
    let(:color) { 'white' }

    it { is_expected.to be_falsey }
  end
end
