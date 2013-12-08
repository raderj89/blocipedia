FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "Person_#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
    plan_id 1
    confirmed_at Time.now
  end

  factory :wiki do
    title "foobar"
    body "foobar nova scotia" * 10
    user
  end
end