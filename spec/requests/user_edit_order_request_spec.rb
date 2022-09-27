require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é o usuário que criou o pedido' do
    # Arrange
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    order = FactoryBot.create(:order, user: user1)
    # Act
    login_as(user2)
    patch(order_path(order), params: { order: { supplier_id: 3}})
    # Assert
    expect(response).to redirect_to(root_path)
  end
end
