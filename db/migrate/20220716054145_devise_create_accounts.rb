# frozen_string_literal: true

class DeviseCreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      ## Database authenticatable
      t.integer :account_number,    null: false
      t.string :encrypted_password, null: false
      t.integer :balance,           null: false, default: 0

      t.timestamps null: false
    end

    add_index :accounts, :account_number,       unique: true
  end
end
