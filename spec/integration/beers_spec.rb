# frozen_string_literal: true

require 'swagger_helper'

describe 'beers' do
  path '/beers' do
    let!(:user) { create(:user) }
    let!(:beer) { create(:beer) }

    get 'returns the beers' do
      tags 'beers'
      produces 'application/json'

      response 200, 'when authenticated' do
        schema '$ref' => '#/definitions/beers_response'

        let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }
        let('Authorization') { "Bearer #{token}" }

        before { |example| submit_request(example.metadata) }

        it 'returns a valid 200 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end

      response 401, 'when unauthenticated' do
        schema '$ref' => '#/definitions/error_response'

        let('Authorization') { '' }

        before { |example| submit_request(example.metadata) }

        it 'returns a valid 401 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
