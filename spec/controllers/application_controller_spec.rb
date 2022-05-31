require 'rails_helper'

describe ApplicationController, type: :request do

  context 'when authorizing a not registered user' do
    it 'returns an unauthorized error' do
      headers = { 'Authorization' => "Bearer " }

      get '/api/v1/service_providers', headers: headers

      expect_unauthorized_error
    end
  end
end