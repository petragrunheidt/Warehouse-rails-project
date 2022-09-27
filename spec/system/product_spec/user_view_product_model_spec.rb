require 'rails_helper'

describe 'Usuário clica em pagina de modelos de produtos' do

    it 'e vê mais detalhes do produto' do
        # Arrange
        user = FactoryBot.create(:user)
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
            city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        ProductModel.create!(name: 'Bolo', weight: 50, width: 50, heigth: 50,
            depth: 50, sku: 'TV23-SMED-XPT12-KMT7', supplier: sup)
        # Act
        login_as(user)
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
        user = FactoryBot.create(:user)
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
            city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        ProductModel.create!(name: 'Bolo', weight: 50, width: 50, heigth: 50,
            depth: 50, sku: 'TV23-SMED-XPT12-KMT7', supplier: sup)

        # Act
        login_as(user)
        visit root_path
        within('nav') do
        click_on 'Modelos de Produtos'
        end
        click_on 'Bolo'
        click_on 'Voltar'

        # Assert
        expect(current_path).to eq product_models_path
    end
    it 'e ve produtos na pagina do fornecedor' do
        # Arrange
        user = FactoryBot.create(:user)
        sup1 = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
            city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        sup2 = Supplier.create!(corporate_name: 'PUTR ltda', brand_name: 'Pitru', registration_number: '3940193300013',
            city: 'Petropolis', state: 'MG', email: 'pitrumail', address: 'Rua da não Petra')
        ProductModel.create!(name: 'TV - Rosa', weight: 50, width: 50, heigth: 50,
            depth: 50, sku: 'TV23-SMED-XPT12-KMT7', supplier: sup1)
        ProductModel.create!(name: 'MicroOndas', weight: 30, width: 30, heigth: 30,
            depth: 30, sku: 'MO24-VIDA-XPT15-KMT5', supplier: sup2)
         # Act
         login_as(user)
         visit root_path
         within('nav') do
         click_on 'Fornecedores'
         end
         click_on 'Petra'

         # Assert
         expect(page).to have_content 'Produtos deste Fornecedor'
         expect(page).to have_content 'Produto: TV - Rosa'
         expect(page).to have_content 'Dimensões: 50x50x50cm'
         expect(page).to have_content 'SKU: TV23-SMED-XPT12-KMT7'
         expect(page).not_to have_content 'MicroOndas'
         expect(page).not_to have_content 'MO24-VIDA-XPT15-KMT5'
    end

end
