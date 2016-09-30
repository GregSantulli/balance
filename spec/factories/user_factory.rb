FactoryGirl.define do
  factory :user_with_group_and_expense, class: User do
    first_name 'Greg'
    last_name  'Santulli'
    email 'greg@santulli.com'
    password 'password'
    after(:create) do |user|
      group = FactoryGirl.create(:group)
      user.groups << group
      FactoryGirl.create(:expense, user: user, group: group)
    end
  end

  factory :user do
    first_name 'Peter'
    last_name  'Cherry'
    email 'peter@cherry.com'
    password 'password'
  end

end