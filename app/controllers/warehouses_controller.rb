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

    def edit
        @warehouse = Warehouse.find(params[:id])
    end

    def update
        @warehouse = Warehouse.find(params[:id])
        warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :area, :address,
            :cep, :description)

        if @warehouse.update(warehouse_params)
            return redirect_to warehouse_path(@warehouse.id), notice: 'Galpão editado com sucesso!'
        end
        render :new

    end
end