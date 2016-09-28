require 'spec_helper'

RSpec.describe Group, type: :model do

  it { should have_many(:expenses) }
  it { should have_many(:memberships) }
  it { should have_many(:users).through(:memberships) }

  describe "instance methods" do

    before(:each) do

    end

  end

end
