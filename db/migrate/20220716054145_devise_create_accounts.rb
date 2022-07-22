# frozen_string_literal: true

class DeviseCreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts, id: false do |t|
      ## Database authenticatable
      t.primary_key :account_number,    null: false
      t.string :encrypted_password, null: false
      t.decimal :balance,           null: false, default: 0

      t.timestamps null: false
    end

    add_index :accounts, :account_number,       unique: true
  end
end
