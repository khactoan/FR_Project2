require 'rails_helper'

RSpec.describe "admin/posts/show", type: :view do
  before(:each) do
    @admin_post = assign(:admin_post, Admin::Post.create!(
      :title => "Title",
      :content => "MyText",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
