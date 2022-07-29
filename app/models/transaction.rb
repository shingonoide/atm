class Transaction < ApplicationRecord
  belongs_to :account, foreign_key: :account_account_number, primary_key: :account_number
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  paginates_per 20
end
