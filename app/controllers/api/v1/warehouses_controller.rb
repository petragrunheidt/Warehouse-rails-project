class Api::V1::WarehousesController < Api::V1::ApiController

  before_action :warehouse_params, only: [:create]

  def index
    warehouses = Warehouse.all
    render status: 200, json: warehouses, except: [:created_at, :updated_at]
  end

  def show
      warehouse = Warehouse.find(params[:id])
      render status: 200, json: warehouse, except: [:created_at, :updated_at]
  end

  def create
    warehouse = Warehouse.new(warehouse_params)
    if warehouse.save
      render status: 201, json: warehouse
    else
      render status: 412, json: { errors: warehouse.errors.full_messages }
    end
  end

  private

  def warehouse_params
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :area, :address,
        :cep, :description)
  end
end
