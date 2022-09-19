require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'length' do
      it 'false when registration number length is not equal to 13' do
        # Arrange
        sup = Supplier.new(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '210039419300013',
          city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')

        # Act
          result = sup.valid?

        # Assert
        expect(result).to eq false
      end
    end
    context 'uniqueness' do
      it 'false when registering a duplicated registration number' do
        # Arrange
        Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '3910392039401',
          city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        sup2 = Supplier.new(corporate_name: 'PMN ltda', brand_name: 'Pumuna', registration_number: '3910392039401',
          city: 'Pumunopolis', state: 'MG', email: 'pumunamail', address: 'Rua da Pumuna')

        # Act
        result = sup2.valid?

        # Assert
        expect(result).to eq false
      end
    end
  end
end
