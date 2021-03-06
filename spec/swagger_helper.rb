require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.to_s + '/swagger'

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:to_swagger' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      securityDefinitions: {
        Bearer: {
          type: 'apiKey',
          name: 'Authorization',
          in: 'header'
        }
      },
      security: [
        { Bearer: [] }
      ],
      definitions: {
        error_response: {
          type: :object,
          properties: {
            error: { type: :string }
          }
        },
        beer: {
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            beer_type: { type: :string },
          },
          required: %w[id name beer_type]
        },
        beer_response: {
          type: :object,
          properties: { 
            beer: { '$ref': '#/definitions/beer' } 
          },
          required: %w[beer]
        },
        beers_response: {
          type: :object,
          properties: {
            beers: { type: :array, items: { '$ref': '#/definitions/beer' } }
          },
          required: %w[beers]
        },
        sign_in_payload: {
          type: :object,
          properties: {
            user: {
              type: :object,
              properties: {
                email: { type: :string },
                password: { type: :string }
              },
              required: %w[email password]
            }
          },
          required: %w[user]
        },
        sign_in_response: {
          type: :object,
          properties: {
            id: { type: :integer },
            email: { type: :string },
            created_at: { type: :string },
            updated_at: { type: :string }
          },
          required: %w[id email created_at updated_at]
        }
      },
      paths: {}
    }
  }
end
