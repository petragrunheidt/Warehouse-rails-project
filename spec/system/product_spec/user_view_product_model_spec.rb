require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
    it 'e vê mais detalhes do produto' do
        # Arrange
        sup = Supplier.create!(brand_name: 'Petra', corporate_name: 'PETR', registration_number: 29304,
            city: 'Petropolis', state: 'SP', email: 'petramail')
        ProductModel.create!(name: 'Bolo', weigth: 50, width: 50, heigth: 50, 
            depth: 50, sku: 'TV23-SMED-XPT12', supplier: sup)
        # Act
        visit root_path
        within('nav') do
        click_on 'Modelos de Produtos'
        end
        click_on 'Bolo'
        
        # Assert
        expect(page).to have_content 'Bolo'
        expect(page).to have_content 'Peso: 50g'
        expect(page).to have_content 'Largura: 50cm'
        expect(page).to have_content 'Altura: 50cm'
        expect(page).to have_content 'Profundidade: 50cm'
        expect(page).to have_content 'SKU: '
        expect(page).to have_content 'Fornecedor: Petra'
    end
    it 'com sucesso' do
        # Arrange
        sup = Supplier.create!(brand_name: 'Petra', corporate_name: 'PETR', registration_number: 29304,
            city: 'Petropolis', state: 'SP', email: 'petramail')
        ProductModel.create!(name: 'Bolo', weigth: 50, width: 50, heigth: 50, 
            depth: 50, sku: 'TV23-SMED-XPT12', supplier: sup)
        
        # Act
        visit root_path
        within('nav') do
        click_on 'Modelos de Produtos'
        end
        click_on 'Bolo'
        click_on 'Voltar'
        
        # Assert
        expect(current_path).to eq product_model_path(1)
    end
end