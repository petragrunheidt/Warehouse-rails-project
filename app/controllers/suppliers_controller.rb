class SuppliersController < ApplicationController
    before_action :set_supplier, only: [:show, :edit, :update, :destroy]
    
    def index
        @supplier = Supplier.all
    end

    private

    def set_supplier
        @supplier = Supplier.find(params[:id])
    end

    def supplier_params
        params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :city, :state,
            :email)
    end
end