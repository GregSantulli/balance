class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.belongs_to :user
      t.belongs_to :group
      t.float :amount
      t.string :description

      t.timestamps null: false
    end
  end
end
