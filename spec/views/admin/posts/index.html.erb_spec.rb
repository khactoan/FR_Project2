require 'rails_helper'

RSpec.describe "admin/posts/index", type: :view do
  before(:each) do
    assign(:admin_posts, [
      Admin::Post.create!(
        :title => "Title",
        :content => "MyText",
        :user => nil
      ),
      Admin::Post.create!(
        :title => "Title",
        :content => "MyText",
        :user => nil
      )
    ])
  end

  it "renders a list of admin/posts" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
