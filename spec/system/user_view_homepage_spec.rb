require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e deve estar autenticado' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'e vê o nome da app' do
    # Arrange
    user = FactoryBot.create(:user)
    # Act
    login_as(user)
    visit root_path
    # Assert
    expect(page).to have_link('Galpões & Estoque', href: root_path)
  end

  it 'e vê listagem de galpões' do
    # Arrange
    user = FactoryBot.create(:user)
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'rua', cep: '03940505', description: 'descrição' )
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'rua', cep: '03940505', description: 'descrição' )
    # Act
    login_as(user)
    visit('/')
    # Assert
    expect(page).not_to have_content('Não existem galpões cadastrados')

    expect(page).to have_content('Rio')
    expect(page).to have_content('SDU')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('60.000 m²')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('MCZ')
    expect(page).to have_content('Maceio')
    expect(page).to have_content('50.000 m²')
  end

  it 'e não existem galpões cadastrados' do
    # Arrange
    user = FactoryBot.create(:user)
    
    # Act
    login_as(user)
    visit root_path

    # Assert
    expect(page).to have_content('Não existem galpões cadastrados')
  end
end
