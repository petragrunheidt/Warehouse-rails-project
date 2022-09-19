require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'length' do
      it 'false when CNPJ length is not equal to 13' do
        # Arrange
        sup = Supplier.new(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '210039419300013',
          city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')

        # Act
          result = sup.valid?

        # Assert
        expect(result).to eq false
      end
    end
  end
end
