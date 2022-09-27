require 'rails_helper'

describe 'Usuário edita um galpão' do
    it 'a partir da página de detalhes' do
        # Arrange
        user = FactoryBot.create(:user)
        warehouse = Warehouse.create!(name: 'R', code: 'RIO', address: 'rua',
                                        cep: '25930030', city: 'Rio',
                                        area: 5320, description: 'descrição')

        # Act
        login_as(user)
        visit root_path
        click_on 'R'
        click_on 'Editar'

        # Assert
        expect(page).to have_content('Editar dados do Galpão')
        expect(page).to have_field('Nome', with: 'R')
        expect(page).to have_field('Código', with: 'RIO')
        expect(page).to have_field('Cidade', with: 'Rio')
        expect(page).to have_field('Area')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('CEP')
        expect(page).to have_field('Descrição')
    end
    it 'e edita dados do galpão com sucesso' do
        # Arrange
        user = FactoryBot.create(:user)
        warehouse = Warehouse.create!(name: 'R', code: 'RID', address: 'rua',
            cep: '25930030', city: 'Rio',
            area: 5320, description: 'descrição')

        # Act
        login_as(user)
        visit root_path
        click_on 'R'
        click_on 'Editar'
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
        expect(page).to have_content '32.000 m²'
        expect(page).to have_content 'Avenida do Museu do Amanhã, 1000'
        expect(page).to have_content '20100-000'
        expect(page).to have_content 'Galpão da zona portuária do Rio'
        expect(page).to have_content 'Galpão editado com sucesso!'
    end
    it 'e mantém campos obrigatórios' do
        # Arrange
        user = FactoryBot.create(:user)
        warehouse = Warehouse.create!(name: 'R', code: 'RID', address: 'rua',
            cep: '25930030', city: 'Rio',
            area: 5320, description: 'descrição')

        # Act
        login_as(user)
        visit root_path
        click_on 'R'
        click_on 'Editar'
        fill_in 'Nome', with: ''
        fill_in 'Código', with: 'RIO'
        fill_in 'Cidade', with: ''
        fill_in 'Area', with: ''
        fill_in 'Endereço', with: ''
        fill_in 'CEP', with: '20100-000'
        fill_in 'Descrição', with: 'Galpão da zona portuária do Rio'
        click_on 'Enviar'

        # Assert
        expect(page).to have_content 'Nome não pode ficar em branco'
        expect(page).to have_content 'Cidade não pode ficar em branco'
        expect(page).to have_content 'Endereço não pode ficar em branco'

    end
end
