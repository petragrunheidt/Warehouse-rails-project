require 'rails_helper'

describe 'Usuário se autentifica' do
  it 'com sucesso' do
    # Arrange
    User.create!(name: 'Petra', email: 'petramail@gmail.com', password: 'password')
    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'petramail@gmail.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    # Assert
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Olá, Petra!'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end
  it 'e faz logout' do
    # Arrange
    User.create!(name: 'Petra', email: 'petramail@gmail.com', password: 'password')
    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'petramail@gmail.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Sair'

    # Assert
    within('nav') do
      expect(page).to have_link 'Entrar'
      expect(page).not_to have_button 'Sair'
      expect(page).not_to have_content 'Olá, Petra!'
    end
    expect(page).to have_content 'Logout efetuado com sucesso.'
  end
end
