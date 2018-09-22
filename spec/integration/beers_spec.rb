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

        it 'returns the available beers' do
          body = JSON.parse(response.body)
          expect(body).to eq('beers' => [beer.attributes.slice('id', 'name', 'beer_type')])
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

    post 'creates a beer' do
      tags 'beers'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :data, in: :body, schema: { '$ref' => '#/definitions/beer_response' }
      let(:data) { { beer: { name: '1717', beer_type: 'unfiltered' } } }

      response 201, 'when authenticated' do
        schema '$ref' => '#/definitions/beer_response'

        let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }
        let('Authorization') { "Bearer #{token}" }

        before { |example| submit_request(example.metadata) }

        it 'returns a valid 201 response' do |example|
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

  path '/beers/{id}' do
    let!(:user) { create(:user) }
    let!(:beer) { create(:beer) }

    get 'returns the beer' do
      tags 'beers'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer

      context 'when authenticated' do
        response 200, 'when beer is found' do
          schema '$ref' => '#/definitions/beer_response'

          let(:id) { beer.id }

          let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }
          let('Authorization') { "Bearer #{token}" }

          before { |example| submit_request(example.metadata) }

          it 'returns a valid 200 response' do |example|
            assert_response_matches_metadata(example.metadata)
          end
        end

        response 404, 'when beer is not found' do
          schema '$ref' => '#/definitions/error_response'

          let(:id) { 0 }

          let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }
          let('Authorization') { "Bearer #{token}" }

          before { |example| submit_request(example.metadata) }

          it 'returns a valid 404 response' do |example|
            assert_response_matches_metadata(example.metadata)
          end
        end
      end

      response 401, 'when unauthenticated' do
        schema '$ref' => '#/definitions/error_response'

        let(:id) { beer.id }

        let('Authorization') { '' }

        before { |example| submit_request(example.metadata) }

        it 'returns a valid 401 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end

    put 'updates the beer' do
      tags 'beers'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter name: :data, in: :body, schema: { '$ref' => '#/definitions/beer_response' }
      let(:data) { { beer: { name: '1717', beer_type: 'unfiltered' } } }

      context 'when authenticated' do
        response 200, 'when beer is found' do
          schema '$ref' => '#/definitions/beer_response'

          let(:id) { beer.id }

          let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }
          let('Authorization') { "Bearer #{token}" }

          before { |example| submit_request(example.metadata) }

          it 'returns a valid 200 response' do |example|
            assert_response_matches_metadata(example.metadata)
          end
        end

        response 404, 'when beer is not found' do
          schema '$ref' => '#/definitions/error_response'

          let(:id) { 0 }

          let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }
          let('Authorization') { "Bearer #{token}" }

          before { |example| submit_request(example.metadata) }

          it 'returns a valid 404 response' do |example|
            assert_response_matches_metadata(example.metadata)
          end
        end
      end

      response 401, 'when unauthenticated' do
        schema '$ref' => '#/definitions/error_response'

        let(:id) { beer.id }

        let('Authorization') { '' }

        before { |example| submit_request(example.metadata) }

        it 'returns a valid 401 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end

    delete 'deletes the beer' do
      tags 'beers'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer

      context 'when authenticated' do
        response 200, 'when beer is found' do
          schema type: :empty

          let(:id) { beer.id }

          let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }
          let('Authorization') { "Bearer #{token}" }

          before { |example| submit_request(example.metadata) }

          it 'returns a valid 200 response' do |example|
            assert_response_matches_metadata(example.metadata)
          end
        end

        response 404, 'when beer is not found' do
          schema '$ref' => '#/definitions/error_response'

          let(:id) { 0 }

          let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }
          let('Authorization') { "Bearer #{token}" }

          before { |example| submit_request(example.metadata) }

          it 'returns a valid 404 response' do |example|
            assert_response_matches_metadata(example.metadata)
          end
        end
      end

      response 401, 'when unauthenticated' do
        schema '$ref' => '#/definitions/error_response'

        let(:id) { beer.id }

        let('Authorization') { '' }

        before { |example| submit_request(example.metadata) }

        it 'returns a valid 401 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
