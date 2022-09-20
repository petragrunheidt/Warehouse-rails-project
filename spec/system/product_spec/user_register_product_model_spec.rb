require 'rails_helper'

describe 'Usuário entra na pagina de cadastrar modelo de produto' do
    it 'se estiver autenticado' do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            click_on 'Cadastrar novo Modelo de Produto'
        end
        # Assert
        expect(current_path).to eq new_user_session_path

    end
    it 'a partir da tela inicial' do
        # Arrange
        user = User.create!(name: 'Petra', email: 'petramail@gmail.com', password: 'password')
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
            city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        # Act
        login_as(user)
        visit root_path
        within('nav') do
        click_on 'Cadastrar novo Modelo de Produto'
        end

        # Assert
        expect(page).to have_field 'Nome'
        expect(page).to have_field 'Peso'
        expect(page).to have_field 'Largura'
        expect(page).to have_field 'Altura'
        expect(page).to have_field 'Profundidade'
        expect(page).to have_field 'SKU'
        expect(page).to have_field 'Fornecedor'

    end

    it 'com sucesso' do
        # Arrange
        user = User.create!(name: 'Petra', email: 'petramail@gmail.com', password: 'password')
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
            city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        # Act
        login_as(user)
        visit root_path
        within('nav') do
        click_on 'Cadastrar novo Modelo de Produto'
        end
        fill_in 'Nome do Produto', with: 'Panela'
        fill_in 'Peso', with: '20'
        fill_in 'Largura', with: '20'
        fill_in 'Altura', with: '20'
        fill_in 'Profundidade', with: '20'
        fill_in 'SKU', with: 'PN20-49TMTN'
        select 'Petra', :from => 'Fornecedor:'
        click_on 'Enviar'

        # Assert
        expect(current_path).to eq product_model_path('1')
        expect(page).to have_content 'Modelo cadastrado com sucesso!'
        expect(page).to have_content 'Panela'
        expect(page).to have_content 'Peso: 20g'
        expect(page).to have_content 'Largura: 20cm'
        expect(page).to have_content 'Altura: 20cm'
        expect(page).to have_content 'Profundidade: 20cm'
        expect(page).to have_content 'SKU: PN20-49TMTN'
        expect(page).to have_content 'Fornecedor: Petra'
    end

    it 'com dados incompletos' do
        # Arrange
        user = User.create!(name: 'Petra', email: 'petramail@gmail.com', password: 'password')
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
            city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        # Act
        login_as(user)
        visit root_path
        within('nav') do
        click_on 'Cadastrar novo Modelo de Produto'
        end
        fill_in 'Nome do Produto', with: 'Panela'
        fill_in 'Peso', with: ''
        fill_in 'Largura', with: ''
        fill_in 'Altura', with: ''
        fill_in 'Profundidade', with: ''
        fill_in 'SKU', with: ''
        select 'Petra', :from => 'Fornecedor:'
        click_on 'Enviar'

        # Assert
        expect(page).to have_content 'SKU não pode ficar em branco'
        expect(page).to have_content 'Peso não pode ficar em branco'
        expect(page).to have_content 'Largura não pode ficar em branco'
        expect(page).to have_content 'Altura não pode ficar em branco'
        expect(page).to have_content 'Profundidade não pode ficar em branco'

    end
end
