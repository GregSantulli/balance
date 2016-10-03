FactoryGirl.define do
  factory :expense do
    description "test_expense"
    amount 2.50
    date Date.today
  end
end