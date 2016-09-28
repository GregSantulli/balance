FactoryGirl.define do
  factory :user do
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

  # # This will use the User class (Admin would have been guessed)
  # factory :admin, class: User do
  #   first_name "Admin"
  #   last_name  "User"
  # end
end