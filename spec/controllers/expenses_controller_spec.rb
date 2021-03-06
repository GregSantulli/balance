require 'spec_helper'

describe ExpensesController do
  include Devise::Test::ControllerHelpers

  let (:user) { FactoryGirl.create(:user_with_group_and_expense) }
  let (:group) { user.groups.first }
  let (:expense) { group.expenses.first }

  before(:each) do
    sign_in user
  end

  describe "POST create" do

    let (:valid_expense_params) {
      {
        group_id: group.id,
        expense:
        {
          description: 'test_expesne',
          amount: 2.50,
          date: Date.today
        }
      }
    }

    it "creates a new expense" do
      expect{post :create, valid_expense_params}.to change{Expense.count}.by(1)
    end

    it "adds the expense to the current groups expenses" do
      expect{post :create, valid_expense_params}.to change{group.expenses.count}.by(1)
    end

    it "assigns @group" do
      post :create, valid_expense_params
      expect(assigns(:group)).to eq(group)
    end

    it "assigns @expense" do
      post :create, valid_expense_params
      expect(assigns(:expense)).to_not be_nil
    end

    it "redirects to group path" do
      post :create, valid_expense_params
      expect(response).to redirect_to(group_path assigns(:group))
    end

  end

  describe "DELETE destroy" do

    it "destroys an expense if current user created it" do
      expect{delete :destroy, {group_id: group.id, id: expense.id}}.to change{Expense.count}.by(-1)
    end

    it "does not destroy an expense if current user did not create it" do
      other_user = FactoryGirl.create(:user)
      group.users << other_user
      unowned_expense = FactoryGirl.create(:expense, user: other_user, group: group)
      expect{delete :destroy, {group_id: group.id, id: unowned_expense.id}}.to_not change{Expense.count}
    end

    it "redirects to the group path" do
      delete :destroy, {group_id: group.id, id: expense.id}
      expect(response).to redirect_to(group_path assigns(:group))
    end

  end

end
