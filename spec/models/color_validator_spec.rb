require "rails_helper"

RSpec.describe ColorValidator do
  subject { model_class.new(color) }

  let(:model_class) do
    Struct.new(:color) do
      include ActiveModel::Validations
      def self.name
        "ColorModel"
      end
      validates :color, color: true
    end
  end

  context "when color-code is valid" do
    let(:color) { '#ffffff' }

    it { is_expected.to be_valid }
  end
end
