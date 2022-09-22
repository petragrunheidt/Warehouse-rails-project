require 'rails_helper'

describe 'Usuário acessa a pagina de editar modelos de produto' do
    it 'e vê campos editaveis de um modelo de produto' do
        # Arrange
        user = User.create!(name: 'Petra', email: 'petramail@gmail.com', password: 'password')
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
            city: 'Petraopolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        sup2 = Supplier.create!(brand_name: 'Petrux', corporate_name: 'PETR ltda', registration_number: '2930430491031',
            city: 'Petolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        ProductModel.create!(name: 'Bolo', weigth: 50, width: 50, heigth: 50,
            depth: 50, sku: 'TV23-SMED-XPT12-KMT7', supplier: sup)
        # Act
        login_as(user)
        visit root_path
        within('nav') do
        click_on 'Modelos de Produtos'
        end
        click_on 'Bolo'
        click_on 'Editar'

        # Assert
        expect(page).to have_field 'Nome'
        expect(page).to have_field 'Peso'
        expect(page).to have_field 'Largura'
        expect(page).to have_field 'Altura'
        expect(page).to have_field 'Profundidade'
        expect(page).to have_field 'SKU'
        expect(page).to have_field 'Fornecedor'

    end
    it 'e edita um modelo de produto com sucesso' do
        # Arrange
        user = User.create!(name: 'Petra', email: 'petramail@gmail.com', password: 'password')
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
            city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        ProductModel.create!(name: 'Bolo', weigth: 50, width: 50, heigth: 50,
            depth: 50, sku: 'TV23-SMED-XPT12-KMT7', supplier: sup)

        # Act
        login_as(user)
        visit root_path
        within('nav') do
        click_on 'Modelos de Produtos'
        end
        click_on 'Bolo'
        click_on 'Editar'
        fill_in 'Nome', with: 'Panela'
        fill_in 'Peso', with: '20'
        fill_in 'Largura', with: '20'
        fill_in 'Altura', with: '20'
        fill_in 'Profundidade', with: '20'
        fill_in 'SKU', with: 'PN20-49TMTN-TK3042CD'
        select 'Petra', :from => 'Fornecedor'
        click_on 'Enviar'


        # Assert
        expect(current_path).to eq product_model_path(1)
        expect(page).to have_content 'Modelo editado com sucesso!'
    end
    it 'e encontra erros ao cadastrar produto sem um dos campos' do
        # Arrange
        user = User.create!(name: 'Petra', email: 'petramail@gmail.com', password: 'password')
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
            city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        ProductModel.create!(name: 'Bolo', weigth: 50, width: 50, heigth: 50,
            depth: 50, sku: 'TV23-SMED-XPT12-KMT7', supplier: sup)

        # Act
        login_as(user)
        visit root_path
        within('nav') do
        click_on 'Modelos de Produtos'
        end
        click_on 'Bolo'
        click_on 'Editar'
        fill_in 'Nome', with: 'Panela'
        fill_in 'Peso', with: '20'
        fill_in 'Largura', with: '20'
        fill_in 'Altura', with: '20'
        fill_in 'Profundidade', with: '20'
        fill_in 'SKU', with: ''
        select 'Petra', :from => 'Fornecedor:'
        click_on 'Enviar'

        # Assert
        expect(page).to have_content 'SKU não pode ficar em branco'
    end
end
