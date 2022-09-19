class ProductModelsController < ApplicationController
    before_action :set_product_model, only: [:show, :edit, :update, :destroy]

    def index
        @product_models = ProductModel.all
    end

    def show; end

    def new
        @product_model = ProductModel.new
        @suppliers = Supplier.all
    end

    def create
        @suppliers = Supplier.all
        @product_model = ProductModel.new(product_model_params)

        if @product_model.save
            return redirect_to @product_model, notice: 'Modelo cadastrado com sucesso!'
        end
        render :new
    end

    def edit
        @suppliers = Supplier.all
    end

    def update
        @suppliers = Supplier.all
        if @product_model.update(product_model_params)
            return redirect_to @product_model, notice: 'Modelo editado com sucesso!'
        end
        render :new
    end

    private

    def set_product_model
        @product_model = ProductModel.find(params[:id])
    end

    def product_model_params
        params.require(:product_model).permit(:name, :weigth, :width, :heigth, :depth, :sku, :supplier_id)
    end
end
