require 'spec_helper'

describe GroupsController do

    let (:user) { User.create!(email: "my@email.com", password: "password") }
    let (:group) { group = Group.create }

    before(:each) do
      sign_in user
      group.expenses << Expense.create!(user_id: user.id, description: "test_expense", amount: 2.50)
    end

    describe "GET show" do

      before(:each) do
        user.groups << group
      end

      it "assigns @group" do
        get :show, id: group.id
        expect(assigns(:group)).to eq group
      end

      it "assigns @expenses" do
        get :show, id: group.id
        expect(assigns(:expenses)).to eq group.expenses.where(settled: [false, nil]).order(created_at: :desc)
      end

      it "assigns @total_outstanding" do
        get :show, id: group.id
        expect(assigns(:total_outstanding)).to eq group.expenses.where(settled: [false, nil]).sum(:amount)
      end

      it "assigns @split" do
        get :show, id: group.id
        expect(assigns(:split)).to eq group.expenses.where(settled: [false, nil]).sum(:amount) / group.users.count
      end

      it "assigns @expense_hash" do
        get :show, id: group.id
        expect(assigns(:expense_hash)).to eq group.user_balance_hash
      end

      it "renders the show template" do
        get :show, id: group.id
        expect(response).to render_template(:show)
      end
    end

    describe "POST create" do

      let (:valid_group_params) { {group: {name: 'test_group'}} }

      it "creates a new group" do
        expect{post :create, valid_group_params}.to change{Group.count}.by(1)
      end

      it "adds the group to the current users groups" do
        expect{post :create, valid_group_params}.to change{user.groups.count}.by(1)
      end

      it "assigns @group" do
        post :create, valid_group_params
        expect(assigns(:group)).to_not be_nil
      end

      it "redirects to newly created group path" do
        post :create, valid_group_params
        expect(response).to redirect_to(group_path assigns(:group))
      end

    end

    describe "GET settle" do

      it "assigns @group" do
        get :settle, group_id: group.id
        expect(assigns(:group)).to eq group
      end

      it "sets all group expenses to settled" do
        get :settle, group_id: group.id
        expect(group.expenses.where(settled: true).count).to eq group.expenses.count
      end

    end


end
