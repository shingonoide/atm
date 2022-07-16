class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.string :type
      t.integer :amount

      t.datetime :created_at, null: false
    end
  end
end
