require 'rails_helper'

describe 'Usuário cadastra um galpão' do
    it 'a partir da tela inicial' do
        # Arrange
        user = FactoryBot.create(:user)
        # Act
        login_as(user)
        visit root_path
        click_on 'Cadastrar Galpão'

        # Assert
        expect(page).to have_field('Nome')
        expect(page).to have_field('Código')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Area')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('CEP')
        expect(page).to have_field('Descrição')

    end

    it 'com sucesso' do
        # Arrange
        user = FactoryBot.create(:user)
        # Act
        login_as(user)
        visit root_path
        click_on 'Cadastrar Galpão'
        fill_in 'Nome', with: 'Rio de Janeiro'
        fill_in 'Código', with: 'RIO'
        fill_in 'Cidade', with: 'Rio de Janeiro'
        fill_in 'Area', with: '32_000'
        fill_in 'Endereço', with: 'Avenida do Museu do Amanhã, 1000'
        fill_in 'CEP', with: '20100000'
        fill_in 'Descrição', with: 'Galpão da zona portuária do Rio'
        click_on 'Enviar'

        # Assert
        expect(current_path).to eq warehouse_path('1')
        expect(page).to have_content 'Rio de Janeiro'
        expect(page).to have_content 'RIO'
        expect(page).to have_content 'Galpão cadastrado com sucesso!'
    end

    it 'com dados incompletos' do
        # Arrange
        user = FactoryBot.create(:user)
        # Act
        login_as(user)
        visit root_path
        click_on 'Cadastrar Galpão'
        fill_in 'Código', with: ''
        fill_in 'Cidade', with: ''
        fill_in 'Area', with: ''
        fill_in 'Endereço', with: ''
        fill_in 'CEP', with: ''
        fill_in 'Descrição', with: ''
        click_on 'Enviar'

        # Assert
        expect(page).to have_content 'Nome não pode ficar em branco'
        expect(page).to have_content 'Código não pode ficar em branco'
        expect(page).to have_content 'Cidade não pode ficar em branco'
        expect(page).to have_content 'Area não pode ficar em branco'
        expect(page).to have_content 'Endereço não pode ficar em branco'
        expect(page).to have_content 'CEP não pode ficar em branco'
        expect(page).to have_content 'Descrição não pode ficar em branco'
    end
    it 'e encontra um erro ao cadastrar um CEP invalido' do
        # Arrange
        user = FactoryBot.create(:user)

        # Act
        login_as(user)
        visit root_path
        click_on 'Cadastrar Galpão'
        fill_in 'Nome', with: 'Rio de Janeiro'
        fill_in 'Código', with: 'RIO'
        fill_in 'Cidade', with: 'Rio de Janeiro'
        fill_in 'Area', with: '32_000'
        fill_in 'Endereço', with: 'Avenida do Museu do Amanhã, 1000'
        fill_in 'CEP', with: '20100'
        fill_in 'Descrição', with: 'Galpão da zona portuária do Rio'
        click_on 'Enviar'

        # Assert
        expect(page).to have_content 'CEP não possui o tamanho esperado (8 caracteres)'

    end
end
