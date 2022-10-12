require 'rails_helper'

describe 'Usuário vê o estoque' do
  it 'na tela do galpão' do
    # Arrange
    user = FactoryBot.create(:user)
    warehouse = FactoryBot.create(:warehouse)
    supplier = FactoryBot.create(:supplier)
    productA = FactoryBot.create(:product_model, supplier: supplier)
    productB = FactoryBot.create(:product_model, supplier: supplier)
    productC = FactoryBot.create(:product_model, supplier: supplier)
    order = FactoryBot.create(:order, warehouse: warehouse)
    3.times {FactoryBot.create(:stock_product, warehouse: warehouse, product_model: productA, order: order)}
    2.times {FactoryBot.create(:stock_product, warehouse: warehouse, product_model: productB, order: order)}
    # Act
    login_as(user)
    visit root_path
    click_on warehouse.name

    # Assert
    expect(page).to have_content "Itens em Estoque"
    expect(page).to have_content "3x #{productA.sku}"
    expect(page).to have_content "2x #{productB.sku}"
    expect(page).not_to have_content productC.sku

  end
end
