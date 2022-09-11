class Warehouse < ApplicationRecord
    def show
        @warehouses = Warehouse.find(params[:id])
    end

    def new
        @warehouses = Warehouse.new
    end

    def create
        @warehouses = Warehouse.new(name: params[:warehouse][:name],
                                name: params[:warehouse][:code],
                                name: params[:warehouse][:city],
                                name: params[:warehouse][:area])
    end
end
