require 'rails_helper'

RSpec.describe Warehouse, type: :model do
    describe '#valid?' do
        context 'presence' do
        it 'false when name is empty' do
            # Arrange
            warehouse = Warehouse.new(name: '', code: 'Rio', address: 'rua', 
                cep: '25930-030', city: 'Rio', 
                area: 0320, description: 'descrição')           
            # Act
            result = warehouse.valid?
            # Assert
            expect(result).to eq false
        end
        it 'false when name is empty' do
            # Arrange
            warehouse = Warehouse.new(name: '', code: 'Rio', address: 'rua', 
                cep: '25930-030', city: 'Rio', 
                area: 0320, description: 'descrição')           
            # Act
            result = warehouse.valid?
            # Assert
            expect(result).to eq false
        end
        it 'false when code is empty' do
            # Arrange
            warehouse = Warehouse.new(name: 'dsa', code: '', address: 'rua', 
                cep: '25930-030', city: 'Rio', 
                area: 0320, description: 'descrição')           
            # Act
            result = warehouse.valid?
            # Assert
            expect(result).to eq false
        end
        it 'false when address is empty' do
            # Arrange
            warehouse = Warehouse.new(name: 'sda', code: 'Rio', address: '', 
                cep: '25930-030', city: 'Rio', 
                area: 0320, description: 'descrição')           
            # Act
            result = warehouse.valid?
            # Assert
            expect(result).to eq false
        end
    end
        context 'uniqueness' do
        it 'false when code is already in use' do
            # Arrange
            warehouse1 = Warehouse.create(name: 'R', code: 'RIO', address: 'rua', 
                cep: '25930-030', city: 'Rio', 
                area: 0320, description: 'descrição')   

            warehouse2 = Warehouse.new(name: 'aR', code: 'RIO', address: 'arua', 
                cep: 'a25930-030', city: 'aRio', 
                area: 10320, description: 'adescrição')  
        
            # Act
            result = warehouse2.valid?
            
            # Assert
            expect(result).to eq false
        end
    end
    context 'length' do
    it 'false when code lenght is not 3' do
        # Arrange
        warehouse = Warehouse.create(name: 'R', code: 'RIOS', address: 'rua', 
            cep: '25930-030', city: 'Rio', 
            area: 0320, description: 'descrição')
        # Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq false
        end    
    end
    #
    end
end
