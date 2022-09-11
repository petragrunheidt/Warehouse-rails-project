require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do
    it 'e vê informações adicionais' do
        # Arrange
        Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 120_000, 
            address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
            description: 'Galpão destinado para cargas internacionais')
        
        # Act
        visit('/')
        click_on('Aeroporto SP')

        # Assert
        expect(page).to have_content('Galpão GRU')
        expect(page).to have_content('Aeroporto SP')
        expect(page).to have_content('Cidade: Guarulhos')
        expect(page).to have_content('Area: 120.000 m²')
        expect(page).to have_content('Endereço: Avenida do Aeroporto, 1000, CEP: 15000-000')
        expect(page).to have_content('Descrição: Galpão destinado para cargas internacionais')
    end
end