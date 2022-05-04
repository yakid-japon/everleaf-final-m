FactoryBot.define do
  factory :user do
    name { "test" }
    email { "test@mail.com" }
    password { "123456" }
    is_admin { false }
  end

  factory :another_user, class: User do
    name { "admin" }
    email { "admin@mail.com" }
    password { "123456" }
    is_admin { true }
  end
end
