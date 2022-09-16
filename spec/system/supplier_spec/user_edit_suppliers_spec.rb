require 'rails_helper'

describe 'Usuário acessa pagina de editar fornecedor' do
    it 'com sucesso' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'Petra', brand_name: 'PETR', registration_number: 493028304, 
            city: 'Petropolis', state: 'SP', email: 'petramail')
        # Act
        visit root_path
        click_on('Fornecedores')
        click_on('mais informações')
        click_on('Editar')

        # Assert
        expect(page).to have_field 'Nome corporativo'
        expect(page).to have_field 'Nome da marca'
        expect(page).to have_field 'Número de registro'
        expect(page).to have_field 'Cidade'
        expect(page).to have_field 'Estado'
        expect(page).to have_field 'Email'
    
    end
    
    it 'e edita cadastro de fornecedor com sucesso' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'Petra', brand_name: 'PETR', registration_number: 493028304, 
            city: 'Petropolis', state: 'SP', email: 'petramail')

        # Act
        visit root_path
        click_on('Fornecedores')
        click_on('mais informações')
        click_on('Editar')
        fill_in 'Nome corporativo', with: 'Ptr'
        fill_in 'Nome da marca', with: 'PET'
        fill_in 'Cidade', with: 'São Petra'
        select 'RJ', :from => 'Estado'
        fill_in 'Email', with: 'petramaildsd'
        fill_in 'Número de registro', with: 4924513304
        click_on('Enviar')
        
        # Assert
        expect(current_path).to eq supplier_path(1)
        expect(page).to have_content 'Ptr'
        expect(page).to have_content 'PET'
        expect(page).to have_content 'São Petra'
        expect(page).to have_content 'RJ'
        expect(page).to have_content 'petramaildsd'
        expect(page).to have_content 'Número de registro: 4924513304'
        expect(page).to have_content 'Fornecedor editado com sucesso'
        
    end

    it 'e encontra um erro ao tentar cadastrar sem um dos campos' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'Petra', brand_name: 'PETR', registration_number: 493028304, 
            city: 'Petropolis', state: 'SP', email: 'petramail')

        # Act
        visit root_path
        visit root_path
        click_on('Fornecedores')
        click_on('mais informações')
        click_on('Editar')
        fill_in 'Nome corporativo', with: 'Petra'
        fill_in 'Nome da marca', with: ''
        fill_in 'Cidade', with: 'Petropolis'
        select 'SP', :from => 'Estado'
        fill_in 'Email', with: 'petramail'
        fill_in 'Número de registro', with: 493028304
        click_on('Enviar')
        
        # Assert
        expect(page).to have_content 'Nome da marca não pode ficar em branco'
        
    end
end