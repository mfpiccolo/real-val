class PropertiesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :authenticate_user!
  before_action :find_property, only: [:show, :edit, :update, :destroy]

  def new
    @property = current_user.properties.build
  end

  def index
    @properties = current_user.properties.order(sort_column + " " + sort_direction)
  end

  def create
    @property = current_user.properties.build(property_params)
    if @property.save
      redirect_to property_path(@property)
    else
      render :new
    end
  end

  def show
    @zip = ZipCode.find_by(code: @property.zip)
  end

  def edit
  end

  def update
    if @property.update_attributes(property_params)
      redirect_to property_path(@property)
    else
      render :new
    end
  end

  def destroy
  end


  private

  def property_params
    params.require(:property).permit(:address, :units, :listing_price, :rent_per_month, :sqr_ft, :hoa_fee)
  end

  def find_property
    @property = current_user.properties.find(params[:id])
  end

  def sort_column
    Property.column_names.include?(params[:sort]) ? params[:sort] : "tecr"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

end
