require 'rails_helper'

describe 'Usuário clica em pagina de modelos de produtos' do
    it 'e vê mais detalhes do produto' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
            city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
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
    it 'e volta para a lista de modelos de produtos' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
            city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
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
        expect(current_path).to eq product_models_path
    end
end
