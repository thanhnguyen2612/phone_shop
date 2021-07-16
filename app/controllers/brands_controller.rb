class BrandsController < ApplicationController
  before_action :authenticate_account!
  before_action :authorize_account?, except: [:index]
  before_action :set_brand, only: [:update, :destroy]

  def index
    @brands = Brand.order(:name)
  end

  def create
    @brand = Brand.new(name: params[:name])
    if @brand.save
      redirect_to brands_path, notice: "New brand created successfully."
    else
      redirect_to brands_path, alert: @brand.errors.full_messages
    end
  end

  def update
    if @brand.update(name: params[:new_name])
      redirect_to brands_path, notice: "Brand name updated successfully."
    else
      redirect_to brands_path, alert: @brand.errors.full_messages
    end
  end

  def destroy
    if @brand.destroy
      redirect_to brands_path, notice: "Brand deleted successfully."
    else
      redirect_to brands_path, alert: @brand.errors.full_messages
    end
  end

  private

  def authorize_account?
    unless current_account.manager?
      redirect_to brands_path, alert: "You are not authorized."
    end
  end
  
  def set_brand
    @brand = Brand.find(params[:id])
  end
end
