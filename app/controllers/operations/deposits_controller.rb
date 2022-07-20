class Operations::DepositsController < ApplicationController
  before_action :set_deposit, only: %i[ show ]

  # GET /operations/deposits/1 or /operations/deposits/1.json
  def show
  end

  # GET /operations/deposits/new
  def new
    @deposit = Deposit.new
  end

  # POST /operations/deposits or /operations/deposits.json
  def create
    @deposit = Deposit.new(deposit_params)

    respond_to do |format|
      if @deposit.save
        format.html { redirect_to operations_deposit_url(@deposit), notice: "Deposit was successfully created." }
        format.json { render :show, status: :created, location: @deposit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deposit
      @deposit = Deposit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def deposit_params
      params.require(:deposit).permit(:account_number, :amount)
    end
end
