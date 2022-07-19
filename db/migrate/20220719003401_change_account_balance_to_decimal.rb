class ChangeAccountBalanceToDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :accounts, :balance, :decimal
  end
end
