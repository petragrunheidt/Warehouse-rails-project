require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'e deve estar autenticado' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).not_to have_field('Buscar Pedido')
    expect(page).not_to have_button('Buscar')
  end
  it 'a partir do menu' do
    # Arrange
    user = FactoryBot.build(:user)
    order = FactoryBot.build(:order)

    # Act
    login_as(user)
    visit root_path

    # Assert
    within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end
  it 'e encontra um pedido' do
    # Arrange
    user = FactoryBot.create(:user)
    order = FactoryBot.create(:order)

    # Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    # Assert
    expect(page).to have_content "Resultados da Busca por: #{order.code}"
    expect(page).to have_content '1 Pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Galpão Destino: #{order.warehouse.full_description}"
    expect(page).to have_content "Fornecedor: #{order.supplier.full_description}"
   end
   it 'e entra na pagina do pedido' do
    # Arrange
    user = FactoryBot.create(:user)
    order = FactoryBot.create(:order, user: user)

    # Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'
    click_on order.code

    # Assert
    expect(current_path).to eq order_path(order)
   end
   it 'e não encontra um pedido' do
    # Arrange
    user = FactoryBot.create(:user)

    # Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'a'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content "Nenhum resultado encontrado para a busca por: a"
   end
   it 'e encontra mais do que um pedido' do
    # Arrange
    warehouse1 = FactoryBot.create(:warehouse, code: 'PET')
    warehouse2 = FactoryBot.create(:warehouse, code: 'TEP')
    order1 = FactoryBot.create(:order, warehouse: warehouse1)
    order2 = FactoryBot.create(:order, warehouse: warehouse1)
    order3 = FactoryBot.create(:order, warehouse: warehouse2)
    user = FactoryBot.create(:user)

    # Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order1.warehouse.code
    click_on 'Buscar'

    # Assert
    expect(page).to have_content "Resultados da Busca por: #{order1.warehouse.code}"
    expect(page).to have_content '2 Pedidos encontrados'
    expect(page).to have_content "Galpão Destino: #{order1.warehouse.full_description}"
   end
end
