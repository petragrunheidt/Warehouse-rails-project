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
        p1 = ProductModel.create!(name: 'Bolo', weigth: 50, width: 50, heigth: 50,
            depth: 50, sku: 'TV23-SMED-XPT12', supplier: sup)
        p2 = ProductModel.create!(name: 'Maça', weigth: 30, width: 30, heigth: 30,
            depth: 30, sku: 'TB873-SSDA-KCT2', supplier: sup)

        # Act
        visit root_path
        within('nav') do
        click_on 'Modelos de Produtos'
        end

        # Assert
        expect(current_path).to eq product_models_path
        expect(page).to have_content 'Bolo'
        expect(page).to have_content 'TV23-SMED-XPT12'
        expect(page).to have_content 'Petra'
        expect(page).to have_content 'Maça'
        expect(page).to have_content 'TB873-SSDA-KCT2'

    end
end
