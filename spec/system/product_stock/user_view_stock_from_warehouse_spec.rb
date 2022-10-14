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
    within("section#stock_products") do
      expect(page).to have_content "Itens em Estoque"
      expect(page).to have_content "3x #{productA.sku}"
      expect(page).to have_content "2x #{productB.sku}"
      expect(page).not_to have_content productC.sku
    end
  end
  it 'e da baixa em um item' do
    # Arrange
    user = FactoryBot.create(:user)
    warehouse = FactoryBot.create(:warehouse)
    supplier = FactoryBot.create(:supplier)
    product = FactoryBot.create(:product_model, supplier: supplier)
    order = FactoryBot.create(:order, warehouse: warehouse)
    2.times {FactoryBot.create(:stock_product, warehouse: warehouse, product_model: product, order: order)}

    # Act
    login_as(user)
    visit root_path
    click_on warehouse.name
    select product.sku, from: "Item para Saída"
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço Destino', with: 'Rua das Palmeiras, 100 - Campinas - São Paulo'
    click_on 'Salvar'

    # Assert
    expect(current_path).to eq warehouse_path(warehouse)
    expect(page).to have_content "1x #{product.sku}"
    expect(page).to have_content 'Item retidado com sucesso'
  end
end
