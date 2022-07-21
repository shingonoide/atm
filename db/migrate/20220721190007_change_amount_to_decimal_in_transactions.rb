class ChangeAmountToDecimalInTransactions < ActiveRecord::Migration[7.0]
  def change
    change_column :transactions, :amount, :decimal, null:false
  end
end
