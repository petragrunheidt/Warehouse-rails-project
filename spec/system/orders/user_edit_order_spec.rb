require 'rails_helper'
describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
    # Arrange
    user = FactoryBot.create(:user)
    order = FactoryBot.create(:order, user: user)
    # Act
    visit edit_order_path(order.id)
    # Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'com sucesso' do
    # Arrange
    user = FactoryBot.create(:user)
    order = FactoryBot.create(:order, user: user)
    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: Date.tomorrow + 50
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Pedido Atualizado com Sucesso.'
    expect(page).to have_content "Data Prevista de Entrega: #{I18n.localize(Date.tomorrow + 50)}"
  end
  it 'e volta para a tela inicial ao tentar editar o pedido de outro usuário' do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    order = FactoryBot.create(:order, user: user1)

    # Act
    login_as(user2)
    visit edit_order_path(order)

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content "Permissão negada, pedido de outro usuário"
  end
  it 'e edita o status de pendente para entregue' do
    # Arrange
    user = FactoryBot.create(:user)
    order = FactoryBot.create(:order, user: user)
    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como Entregue'
    # Assert
    expect(page).to have_content 'Status do Pedido atualizado.'
    expect(page).to have_content 'Status: Entregue'
  end
end
