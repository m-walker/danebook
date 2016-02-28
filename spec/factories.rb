FactoryGirl.define do

  factory :user do
    sequence(:first_name) {|n| "Foo#{n}"}
    last_name "Bar"
    email {"#{first_name}@bar.com"}
    password "password"

    factory :user_with_profile do
      after(:create) do |user|
        create(:profile, user_id: user.id)
      end
    end
  end

  factory :post do
    content "Lorem ipsum"
    user

    # factory :post_with_comment do
    #   after(:create) do |post|
    #     create(:comment, user_id: user.id)
    #   end
    # end
  end

end