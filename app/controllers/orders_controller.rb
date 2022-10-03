class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_and_check_user, only: [:show, :edit, :update]
  def index
    @orders = current_user.orders
  end

  def show; end

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
    @orders = Order.where("code LIKE ?", "%#{@query}%")
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all

  end

  def update

    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    if @order.update(order_params)
      return redirect_to @order, notice: 'Pedido Atualizado com Sucesso.'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      render :new
    end
  end
  def pending

  end

  def received

  end

  def canceled

  end

  private

  def set_order_and_check_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      return redirect_to root_path, notice: "Permissão negada, pedido de outro usuário"
    end
  end
end


