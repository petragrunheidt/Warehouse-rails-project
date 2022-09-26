class OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      redirect_to @order, notice: 'Pedido registrado com sucesso.'
    else
      render:new
    end
  end

  def search
    @query = params["query"]
    @orders = Order.where("estimated_delivery_date OR code OR warehouse_id OR supplier_id LIKE ?", "%#{@query}%")
  end
end
