class GaragesController < ApplicationController
  before_action :fetch_garage, only: [:update, :destroy, :edit]
  before_action :verify_update_params, only: [:update]

  def index
    # We could have also used the counter cache here
    # if we needed to further optimize this page
    @garages = Garage
               .joins(:floors)
               .select('garages.*', 'COUNT("floors.id") AS floor_count', 'sum(floors.number_of_spaces) as number_of_spaces')
               .group('garages.id')
  end

  def new
    @garage = Garage.new
    @garage.floors.build
  end

  def create
    @garage = Garage.new(garage_params)

    if @garage&.save
      flash[:success] = 'Successfully added garage!'
      redirect_to garages_path
    else
      render :new
    end
  end

  def destroy
    if @garage.destroy
      flash[:success] = 'Successfully deleted garage!'
    else
      flash[:danger] = 'Cannot delete garage with active parking, please check out first!'
    end

    redirect_to garages_path
  end

  def edit; end

  def update
    if @garage.update(garage_params)
      flash[:success] = 'Successfully updated garage!'
    else
      render :edit
    end

    redirect_to garages_path
  end

  private

  def verify_update_params
    floors_attributes = garage_params['floors_attributes']
    if floors_attributes.keys.size == 1 &&
      floors_attributes.values.find{ |floor| floor['_destroy'] == '1' }
      @garage.errors[:base] << 'Garage cannot exist without any floors'
      return render :edit
    end
  end

  def fetch_garage
    @garage = Garage.find(params[:id])
  end

  def garage_params
    params.require(:garage).permit(
      :name,
      floors_attributes: [ :id, :name, :number_of_spaces, :_destroy ]
    )
  end
end