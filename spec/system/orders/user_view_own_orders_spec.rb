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
end

