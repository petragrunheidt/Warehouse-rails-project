class WarehousesController < ApplicationController
    def show
        @warehouse = Warehouse.find(params[:id])
    end

    def new
        @warehouses = Warehouse.new
    end

    def create
        @warehouses = Warehouse.new(name: params[:warehouse][:name],
                                code: params[:warehouse][:code],
                                city: params[:warehouse][:city],
                                area: params[:warehouse][:area])
    end
end