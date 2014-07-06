class ZipCodesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :authenticate_user!
  before_action :find_zip_code, only: [:show, :edit, :update, :destroy]

  def new
    @zip_code = current_user.zip_codes.build
  end

  def index
    @zip_codes = current_user.zip_codes.order(sort_column + " " + sort_direction)
  end

  def create
    @zip_code = current_user.zip_codes.build(zip_code_params)
    if @zip_code.save
      redirect_to zip_code_path(@zip_code)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @zip_code.update_attributes(zip_code_params)
      redirect_to zip_code_path(@zip_code)
    else
      render :new
    end
  end

  def destroy
  end


  private

  def zip_code_params
    params.require(:zip_code).permit(:code, :z_index_value, :area)
  end

  def find_zip_code
    @zip_code = current_user.zip_codes.find(params[:id])
  end

  def sort_column
    ZipCode.column_names.include?(params[:sort]) ? params[:sort] : "code"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

end
