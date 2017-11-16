FactoryBot.define do
  factory :admin_post, class: 'Admin::Post' do
    title "MyString"
    content "MyText"
    user nil
  end
end
