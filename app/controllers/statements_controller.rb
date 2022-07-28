class StatementsController < ApplicationController
  before_action :authenticate_account!

  def index
    if statements_params[:filter_from].present? || statements_params[:filter_to].present?
      filter_from = statements_params[:filter_from].in_time_zone
      filter_to = statements_params[:filter_to].in_time_zone
    end

    filter_from = Date.today.in_time_zone.to_time unless filter_from
    filter_to = Date.today.in_time_zone.to_time.end_of_day unless filter_to
    @transactions = current_account.transactions.where(
      created_at: filter_from..filter_to,
    ).order(:created_at).page(params[:page])

  end

  private

  def statements_params
    params.permit(:filter_from, :filter_to)
    # .with_defaults(
    #   filter_from: Date.today.in_time_zone,
    #   filter_to: Date.tomorrow.in_time_zone,
    # )
  end

end
