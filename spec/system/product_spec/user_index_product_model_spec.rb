require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
    it 'a partir do menu' do
        # Arrange

        # Act
        visit root_path
        within('nav') do
        click_on 'Modelos de Produtos'
        end

        # Assert
        expect(current_path).to eq product_models_path
    end
    it 'com sucesso' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
            city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        p1 = ProductModel.create!(name: 'Bolo', weight: 50, width: 50, heigth: 50,
            depth: 50, sku: 'TV23-SMED-XPT12-ISC2', supplier: sup)
        p2 = ProductModel.create!(name: 'Maça', weight: 30, width: 30, heigth: 30,
            depth: 30, sku: 'TV23-SMED-XPT12-KMT7', supplier: sup)

        # Act
        visit root_path
        within('nav') do
        click_on 'Modelos de Produtos'
        end

        # Assert
        expect(current_path).to eq product_models_path
        expect(page).to have_content 'Bolo'
        expect(page).to have_content 'TV23-SMED-XPT12-ISC2'
        expect(page).to have_content 'Petra'
        expect(page).to have_content 'Maça'
        expect(page).to have_content 'TV23-SMED-XPT12-KMT7'
    end
end
