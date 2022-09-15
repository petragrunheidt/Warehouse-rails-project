class SuppliersController < ApplicationController
    before_action :set_supplier, only: [:show, :edit, :update, :destroy]
    
    def index
        @supplier = Supplier.all
    end

    def show; end

    def new
        @supplier = Supplier.new
    end

    def create
        @supplier = Supplier.new(supplier_params)
        
        if @supplier.save
            
            return redirect_to supplier_path(@supplier.id), notice: 'Fornecedor registrado com sucesso!'
        end
        render :new
    end

    def edit; end

    def update
        if @supplier.update(supplier_params)
            return redirect_to supplier_path(@supplier.id), notice: 'Fornecedor editado com sucesso!'
        end
        render :new
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