require 'rails_helper'

describe 'Usuário acessa pagina de cadastrar fornecedores' do
    it 'com sucesso' do
        # Arrange

        # Act
        visit root_path
        click_on('Cadastrar novo Fornecedor')

        # Assert
        expect(page).to have_field 'Nome corporativo'
        expect(page).to have_field 'Nome da marca'
        expect(page).to have_field 'CNPJ'
        expect(page).to have_field 'Cidade'
        expect(page).to have_field 'Estado'
        expect(page).to have_field 'Email'

    end

    it 'e cadastra novo fornecedor com sucesso' do
        # Arrange

        # Act
        visit root_path
        click_on('Cadastrar novo Fornecedor')
        fill_in 'Nome corporativo', with: 'Petra'
        fill_in 'Nome da marca', with: 'PETR'
        fill_in 'Endereço', with: 'Rua da não Petra'
        fill_in 'Cidade', with: 'Petropolis'
        select 'SP', :from => 'Estado'
        fill_in 'Email', with: 'petramail'
        fill_in 'CNPJ', with: '0039419300013'
        click_on 'Enviar'

        # Assert
        expect(current_path).to eq supplier_path(1)
        expect(page).to have_content 'Petra'
        expect(page).to have_content 'PETR'
        expect(page).to have_content 'Petropolis'
        expect(page).to have_content 'SP'
        expect(page).to have_content 'petramail'
        expect(page).to have_content 'CNPJ: 00.394.193/0001-3'
        expect(page).to have_content 'Fornecedor registrado com sucesso'

    end

    it 'e encontra um erro ao tentar cadastrar sem um dos campos' do
        # Arrange

        # Act
        visit root_path
        click_on('Cadastrar novo Fornecedor')
        fill_in 'Nome corporativo', with: 'Petra'
        fill_in 'Nome da marca', with: ''
        fill_in 'Endereço', with: 'Rua da não Petra'
        fill_in 'Cidade', with: 'Petropolis'
        select 'SP', :from => 'Estado'
        fill_in 'Email', with: 'petramail'
        fill_in 'CNPJ', with: '0039419300013'
        click_on('Enviar')

        # Assert
        expect(current_path).to eq suppliers_path
        expect(page).to have_content 'Nome da marca não pode ficar em branco'

    end
end
