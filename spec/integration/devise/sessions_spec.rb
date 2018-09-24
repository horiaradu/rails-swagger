# frozen_string_literal: true

require 'swagger_helper'

describe 'sessions' do
  path '/users/sign_in' do
    let!(:user) { create(:user) }

    post 'sign in' do
      tags 'sessions'
      consumes 'application/json'
      produces 'application/json'
      security []

      parameter name: :data, in: :body, schema: { '$ref' => '#/definitions/sign_in_payload' }

      response 200, 'when credentials are valid' do
        let(:data) do
          { user: { email: user.email, password: user.password } }
        end

        schema '$ref' => '#/definitions/sign_in_response'

        before { |example| submit_request(example.metadata) }

        it 'returns a valid 200 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end

      response 401, 'when credentials are invalid' do
        let(:data) do
          { user: { email: user.email, password: 'something else' } }
        end

        schema '$ref' => '#/definitions/error_response'

        before { |example| submit_request(example.metadata) }

        it 'returns a valid 401 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
