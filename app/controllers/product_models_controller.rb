class ProductModelsController < ApplicationController
    before_action :set_product_model, only: [:show, :edit, :update, :destroy]
    
    def index
        @product_models = ProductModel.all
    end

    def show; end

    private

    def set_product_model
        @product_model = ProductModel.find(params[:id])
    end

    def product_model_params
        params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :city, :state,
            :email)
    end
end