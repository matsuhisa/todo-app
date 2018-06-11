require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    before do
      get :new
    end

    it "returns a success response" do
      expect(response).to be_successful
    end
  end
end
