require 'rails_helper'

RSpec.describe "admin/posts/edit", type: :view do
  before(:each) do
    @admin_post = assign(:admin_post, Admin::Post.create!(
      :title => "MyString",
      :content => "MyText",
      :user => nil
    ))
  end

  it "renders the edit admin_post form" do
    render

    assert_select "form[action=?][method=?]", admin_post_path(@admin_post), "post" do

      assert_select "input[name=?]", "admin_post[title]"

      assert_select "textarea[name=?]", "admin_post[content]"

      assert_select "input[name=?]", "admin_post[user_id]"
    end
  end
end
