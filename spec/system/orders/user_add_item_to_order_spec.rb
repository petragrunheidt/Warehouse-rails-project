require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do
    # Arrange
    user = FactoryBot.create(:user)
    sup = FactoryBot.create(:supplier)
    prod1 = FactoryBot.create(:product_model, name: 'TV', supplier: sup)
    prod2 = FactoryBot.create(:product_model, name: 'Geladeira', supplier: sup)
    order1 = FactoryBot.create(:order, user: user, supplier: sup)


    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order1.code
    click_on 'Adicionar Item'
    select 'TV', :from => 'Produtos'
    fill_in 'Quantidade', with: '8'
    click_on 'Enviar'
    # Assert
    expect(current_path).to eq order_path(order1)
    expect(page).to have_content 'Item adicionado com sucesso.'
    expect(page).to have_content '8 x TV'
  end
  it 'e não vê produtos de outro fornecedor' do
    # Arrange
    user = FactoryBot.create(:user)
    sup1 = FactoryBot.create(:supplier)
    sup2 = FactoryBot.create(:supplier)
    prod1 = FactoryBot.create(:product_model, name: 'TV', supplier: sup1)
    prod2 = FactoryBot.create(:product_model, name: 'Geladeira', supplier: sup2)
    order = FactoryBot.create(:order, user: user, supplier: sup1)


    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    # Assert
    expect(page).to have_content 'TV'
    expect(page).not_to have_content 'Geladeira'
  end
end
