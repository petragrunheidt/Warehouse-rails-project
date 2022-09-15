require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor' do
    it 'e vê informações adicionais' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'Petra', brand_name: 'PETR', registration_number: 493028304, 
            city: 'Petropolis', state: 'SP', email: 'petramail')

        # Act
        visit root_path
        click_on('Fornecedores')
        click_on('mais informações')

        # Assert
        expect(current_path).to eq ('/suppliers/1')
        expect(page).to have_content 'Petra'
        expect(page).to have_content 'PETR'
        expect(page).to have_content 'Número de registro: 493028304'
        expect(page).to have_content 'Cidade: Petropolis, Estado: SP'
        expect(page).to have_content 'Email: petramail'
    end
    it 'e volta para tela de fornecedores' do
         # Arrange
         sup = Supplier.create!(corporate_name: 'Petra', brand_name: 'PETR', registration_number: 493028304, 
            city: 'Petropolis', state: 'SP', email: 'petramail')

        # Act
        visit root_path
        click_on('Fornecedores')
        click_on('mais informações')
        click_on('Voltar')

        # Assert
        expect(current_path).to eq suppliers_path
    end
end