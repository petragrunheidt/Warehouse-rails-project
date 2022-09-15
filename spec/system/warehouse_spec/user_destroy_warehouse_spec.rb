require 'rails_helper'

describe 'Usuário deleta um galpão' do
    it 'com sucesso' do
        # Arrange
        warehouse1 = Warehouse.create!(name: 'Ramal', code: 'RIO', address: 'rua', 
            cep: '25930030', city: 'Rio', 
            area: 5320, description: 'descrição')

        # Act
        visit root_path
        click_on 'R'
        click_on 'Deletar'

        # Assert
        expect(page).to have_content("Galpão deletado com sucesso!")
        expect(page).not_to have_content('Ramal')
        expect(page).not_to have_content('RIO')
    end

    it 'e não apaga outros galpões' do
         # Arrange
         warehouse1 = Warehouse.create!(name: 'Ramal', code: 'RIO', address: 'rua', 
            cep: '25930030', city: 'Rio', 
            area: 5320, description: 'descrição')
        warehouse2 = Warehouse.create!(name: 'A', code: 'AIO', address: 'Arua', 
            cep: '55930030', city: 'ARio', 
            area: 55320, description: 'dDeescrição')

        # Act
        visit root_path
        click_on 'R'
        click_on 'Deletar'

        # Assert
        expect(page).to have_content("Galpão deletado com sucesso!")
        expect(page).not_to have_content('Ramal')
        expect(page).not_to have_content('RIO')
        expect(page).to have_content('A')
        expect(page).to have_content('AIO')
        
    end
end
