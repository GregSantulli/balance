require 'spec_helper'

describe GroupsController do

    let (:user) { User.create!(email: "my@email.com", password: "password") }
    let (:group) { group = Group.create }

    before(:each) do
      sign_in user
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

      it "creates a new group" do
        expect{post :create, group: {name: 'test_group'}}.to change{Group.count}.by(1)
      end

    end

end
