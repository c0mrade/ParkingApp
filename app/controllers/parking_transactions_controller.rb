class ParkingTransactionsController < ApplicationController
  include ParkingTransactionHelper

  def index
    @parking_transactions = ParkingTransaction.includes(floor: :garage)
  end

  def new
    # Only floors with available spaces appear
    # knowing that we're working with a small data set
    # to avoid having to make two seperate queries
    # first one that uses exists to check if any floors exist
    # second one to list the floors if the first one returned true
    # see new template line 4 and line 12
    @floors = available_floors_with_parking_spaces.includes(:garage).to_a
    @parking_transaction = ParkingTransaction.new
  end

  def create
    @parking_transaction = ParkingTransaction.new(person_params)

    if @parking_transaction.save
      flash[:success] = 'Successfully checked in!'
      redirect_to(@parking_transaction)
    else
      render :new
    end
  end

  def show
    @parking_transaction = ParkingTransaction.find(params[:id])
  end

  def update
    @parking_transaction = ParkingTransaction.active.find_by(ticket: params[:ticket])

    if @parking_transaction&.update(active: false)
      flash[:success] = 'Successfully checked out!'
      redirect_to root_path
    else
      flash[:danger] = 'Invalid ticket, please try again'
      redirect_to check_out_parking_transactions_path
    end
  end

  def check_out; end

  private

  def person_params
    params.require(:parking_transaction).permit(:floor_id)
  end
end