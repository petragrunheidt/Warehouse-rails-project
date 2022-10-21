require 'rails_helper'

describe 'Warehouse API' do
  context 'Get /api/v1/warehouses/1' do
    it 'success' do
      warehouse = FactoryBot.create(:warehouse, name: 'Galpão teste', code: 'TES', address: 'Endereço')

      get "/api/v1/warehouses/#{warehouse.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq('Galpão teste')
      expect(json_response["code"]).to eq('TES')
      expect(json_response["address"]).to eq('Endereço')
      expect(json_response.keys).not_to include("created_at")
      expect(json_response.keys).not_to include("updated_at")
    end
    it 'fail if warehouse not found' do

      get "/api/v1/warehouses/999"

      expect(response.status).to eq 404
    end
  end
  context 'Get /api/v1/warehouses' do
    it 'success' do
      FactoryBot.create(:warehouse, name: 'Galpão teste 1', code: 'TES', address: 'Endereço 1')
      FactoryBot.create(:warehouse, name: 'Galpão teste 2', code: 'TEZ', address: 'Endereço 2')

      get "/api/v1/warehouses/"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(2)
      expect(json_response[0]["name"]).to eq('Galpão teste 1')
      expect(json_response[0]["code"]).to eq('TES')
      expect(json_response[0]["address"]).to eq('Endereço 1')
      expect(json_response[1]["name"]).to eq('Galpão teste 2')
      expect(json_response[1]["code"]).to eq('TEZ')
      expect(json_response[1]["address"]).to eq('Endereço 2')
      expect(json_response.first.keys).not_to include("created_at")
      expect(json_response.first.keys).not_to include("updated_at")
    end
    it 'returns empty if there are no warehouses' do

      get "/api/v1/warehouses"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
    it 'and raise internal error' do
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get "/api/v1/warehouses/"

      expect(response).to have_http_status 500
    end
  end
  context 'POST /api/v1/warehouses' do
    it 'success' do
      new_warehouse_params = {warehouse: { name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 120_000,
                                            address: 'Avenida do Aeroporto, 1000', cep: '15000000',
                                            description: 'Galpão destinado para cargas internacionais'} }

      post '/api/v1/warehouses', params: new_warehouse_params

      expect(response).to have_http_status(201)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq('Aeroporto SP')
      expect(json_response["code"]).to eq('GRU')
      expect(json_response["city"]).to eq('Guarulhos')
      expect(json_response["area"]).to eq(120_000)
      expect(json_response["cep"]).to eq('15000000')
      expect(json_response["address"]).to eq('Avenida do Aeroporto, 1000')
    end
    it 'fail if parameters are not complete' do
      new_warehouse_params = {warehouse: { name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
        address: 'Avenida do Aeroporto, 1000', cep: '15000000'
        } }

      post '/api/v1/warehouses', params: new_warehouse_params

      expect(response).to have_http_status(412)
      expect(response.body).not_to include 'Nome não pode ficar em branco'
      expect(response.body).not_to include 'Código não pode ficar em branco'
      expect(response.body).to include 'Descrição não pode ficar em branco'
      expect(response.body).to include 'Area não pode ficar em branco'
    end
    it 'fail if there is internal error' do
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      new_warehouse_params = {warehouse: { name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 120_000,
                                            address: 'Avenida do Aeroporto, 1000', cep: '15000000',
                                            description: 'Galpão destinado para cargas internacionais'} }

      post '/api/v1/warehouses', params: new_warehouse_params

      expect(response).to have_http_status(500)
    end
  end
end
