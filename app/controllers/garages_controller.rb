class GaragesController < ApplicationController
  def index
    # We could have also used the counter cache here
    # if we needed to further optimize this page
    @garages = Garage
               .joins(:floors)
               .select('garages.*', 'COUNT("floors.id") AS floor_count')
               .group('garages.id')
  end

  def new
    @garage = Garage.new
    @garage.floors.build
  end

  def create
    binding.pry
  end

  def destroy
    @garage = Garage.find_by(id: params[:id])

    if @garage&.destroy
      flash[:success] = 'Successfully deleted garage!'
    else
      flash[:danger] = 'Cannot delete garage with active parking, please check out first!'
    end

    redirect_to garages_path
  end

  def edit

  end

  private

  def garage_params
    params.require(:garage).permit(
      :name,
      floors_attributes: [ :id, :name, :number_of_spaces, :_destroy ]
    )
  end
end