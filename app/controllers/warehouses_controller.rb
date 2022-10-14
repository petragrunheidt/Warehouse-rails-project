class WarehousesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

    def show
        @product_models = (@warehouse.stock_products.map {|i| i.product_model}).uniq
        @stocks = @warehouse.stock_products.where.missing(:stock_product_destination).group(:product_model).count
    end

    def new
        @warehouse = Warehouse.new
    end

    def create
        @warehouse = Warehouse.new(warehouse_params)

        if @warehouse.save

            return redirect_to warehouse_path(@warehouse.id), notice: 'Galpão cadastrado com sucesso!'
        end
        render :new
    end

    def edit; end

    def update
        if @warehouse.update(warehouse_params)
            return redirect_to warehouse_path(@warehouse.id), notice: 'Galpão editado com sucesso!'
        end
        render :new
    end

    def destroy
        if @warehouse.destroy
            return redirect_to root_path, notice: 'Galpão deletado com sucesso!'
        end

    end

    private

    def set_warehouse
        @warehouse = Warehouse.find(params[:id])
    end

    def warehouse_params
        params.require(:warehouse).permit(:name, :code, :city, :area, :address,
            :cep, :description)
    end
end
