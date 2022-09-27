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
    order1 = FactoryBot.create(:order, user: user1, estimated_delivery_date: 1.day.from_now)
    order2 = FactoryBot.create(:order, user: user2, estimated_delivery_date: 50.day.from_now)
    # Act
    login_as(user1)
    visit root_path
    click_on 'Meus Pedidos'
    # Assert
    expect(page).to have_content "#{Order.human_attribute_name('code')}: #{order1.code}"
    expect(page).to have_content "#{Order.human_attribute_name('warehouse_id')}: #{order1.warehouse.full_description}"
    expect(page).to have_content "Data Prevista de Entrega: #{I18n.localize(order1.estimated_delivery_date)}"
    expect(page).not_to have_content "Data Prevista de Entrega: #{I18n.localize(order2.estimated_delivery_date)}"
  end
  it 'e visita um pedido' do
    # Arrange
    user1 = FactoryBot.create(:user)
    order1 = FactoryBot.create(:order, user: user1)
    # Act
    login_as(user1)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order1.code
    # Assert
    expect(page).to have_content "#{Order.model_name.human} #{order1.code}"
    expect(page).to have_content "#{Order.human_attribute_name('warehouse_id')}: #{order1.warehouse.full_description}"
    expect(page).to have_content "#{Order.human_attribute_name('supplier_id')}: #{order1.supplier.corporate_name}"
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
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end
end

