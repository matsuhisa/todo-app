require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(name: "name", email: "test@example.com", password: "password", password_confirmation: "password"))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do
      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[email]"
    end
  end
end
