require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do
    # Arrange

    # Act
    visit root_path
    # Assert
    expect(page).not_to have_content 'Meus Pedidos'

  end
  it 'e não vê pedidos de outros usuários' do
    # Arrange
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    order1 = FactoryBot.create(:order, user: user1, estimated_delivery_date: 1.day.from_now, status: 0)
    order2 = FactoryBot.create(:order, user: user2, estimated_delivery_date: 50.day.from_now, status: 1)
    # Act
    login_as(user1)
    visit root_path
    click_on 'Meus Pedidos'
    # Assert
    expect(page).to have_content "#{Order.human_attribute_name('code')}: #{order1.code}"
    expect(page).to have_content "#{Order.human_attribute_name('warehouse_id')}: #{order1.warehouse.full_description}"
    expect(page).to have_content "Data Prevista de Entrega: #{I18n.localize(order1.estimated_delivery_date)}"
    expect(page).not_to have_content "Data Prevista de Entrega: #{I18n.localize(order2.estimated_delivery_date)}"
    expect(page).not_to have_content 'Cancelado'
    expect(page).to have_content 'Pendente'
  end
  it 'e visita um pedido' do
    # Arrange
    user = FactoryBot.create(:user)
    prod1 = FactoryBot.create(:product_model, name: 'TV')
    prod2 = FactoryBot.create(:product_model, name: 'Geladeira')
    prod3 = FactoryBot.create(:product_model, name: 'Micro-Ondas')
    order = FactoryBot.create(:order, user: user)
    OrderItem.create!(product_model: prod1, order: order, quantity: 19)
    OrderItem.create!(product_model: prod2, order: order, quantity: 12)
    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    # Assert
    expect(page).to have_content 'Itens do Pedido'
    expect(page).to have_content '19 x TV'
    expect(page).to have_content '12 x Geladeira'
    expect(page).to have_content "#{Order.model_name.human} #{order.code}"
    expect(page).to have_content "#{Order.human_attribute_name('warehouse_id')}: #{order.warehouse.full_description}"
    expect(page).to have_content "#{Order.human_attribute_name('supplier_id')}: #{order.supplier.corporate_name}"

  end
  it 'e não visita pedidos de outros usuários' do
    # Arrange
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    order1 = FactoryBot.create(:order, user: user1)
    order2 = FactoryBot.create(:order, user: user2)
    # Act
    login_as(user1)
    visit order_path(order2)
    # Assert
    expect(current_path).not_to eq order_path(order2)
    expect(page).to have_content "Permissão negada, pedido de outro usuário"
  end
end

