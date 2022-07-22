class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.bigint :account_account_number, null: false
      t.string :type
      t.decimal :amount

      t.datetime :created_at, null: false
    end
    add_foreign_key :transactions, :accounts, column: :account_account_number, primary_key: :account_number
  end
end
