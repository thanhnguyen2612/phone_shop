class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:edit, :update, :destroy]

  def index
    @inventories = Inventory.all
  end

  def new
    @inventory = Inventory.new
    @brands = Brand.all
  end

  def create
    @inventory = Inventory.new(inventory_params)
    
    if @inventory.save
      redirect_to edit_inventory_path(@inventory)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @brands = Brand.all
  end

  def update
    @brands = Brand.all
    if @inventory.update(inventory_params)
      redirect_to edit_inventory_path(@inventory)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @inventory.destroy
    redirect_to inventories_path
  end

  private
  
  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  def inventory_params
    params.require(:inventory).permit(
      :model_id, :memory_size, :manufactoring_year,
      :os_version, :color, :price, :original_price,
      :source, :status, :description, images: []
    )
  end
end
