require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e edita o status de pendente para entregue' do
    # Arrange
    user = FactoryBot.create(:user)
    warehouse = FactoryBot.create(:warehouse)
    sup = FactoryBot.create(:supplier)
    prod = FactoryBot.create(:product_model, name: 'TV', supplier: sup)
    order = FactoryBot.create(:order, user: user, supplier: sup, warehouse: warehouse)
    order_item = FactoryBot.create(:order_item, order:order, product_model: prod, quantity: 10)
    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como Entregue'
    # Assert
    expect(page).to have_content 'Status do Pedido atualizado.'
    expect(page).to have_content 'Status: Entregue'
    expect(page).not_to have_button 'Marcar como Entregue'
    expect(page).not_to have_button 'Marcar como Cancelado'
    expect(StockProduct.count). to eq 10
    stock = StockProduct.where(product_model: prod, warehouse: warehouse).count
    expect(stock).to eq 10
  end
  it 'e cancela o pedido' do
    # Arrange
    user = FactoryBot.create(:user)
    warehouse = FactoryBot.create(:warehouse)
    sup = FactoryBot.create(:supplier)
    prod = FactoryBot.create(:product_model, name: 'TV', supplier: sup)
    order = FactoryBot.create(:order, user: user, supplier: sup, warehouse: warehouse)
    order_item = FactoryBot.create(:order_item, order:order, product_model: prod, quantity: 10)
    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como Cancelado'
    # Assert
    expect(page).to have_content 'Status do Pedido atualizado.'
    expect(page).to have_content 'Status: Cancelado'
    expect(page).not_to have_button 'Marcar como Entregue'
    expect(page).not_to have_button 'Marcar como Cancelado'
    expect(StockProduct.count). to eq 0
  end
end
