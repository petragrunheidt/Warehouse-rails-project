class WarehousesController < ApplicationController
    def show
        @warehouse = Warehouse.find(params[:id])
    end

    def new
        @warehouse = Warehouse.new
    end

    def create
        warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :area, :address,
             :cep, :description)
        @warehouse = Warehouse.new(warehouse_params)
        
        if @warehouse.save
            
            return redirect_to warehouse_path(@warehouse.id), notice: 'Galpão cadastrado com sucesso!'
        end
        render :new
    end
end