require 'rails_helper'
include RequestSpecHelper
include ControllerSpecHelper

RSpec.describe 'Project API', type: :request do
  let(:name) { "test name" }
  let(:user) { create(:user) }
  let!(:projects) { create_list(:project, 10, created_by: user.id) }
  let(:project_id) { projects.first.id }
  let(:headers) { valid_headers }

  describe 'GET /projects' do
    before { get '/projects', params: {}, headers: headers }

    it 'returns projects' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /projects/:id' do
    before { get "/projects/#{project_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the project' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(project_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:project_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Project/)
      end
    end
  end

  describe 'POST /projects' do
    let(:valid_attributes) do
      { title: 'Learn Elm', description: 'Igogo', created_by: user.id.to_s, likes: 5.to_s }.to_json
    end 

    context 'when the request is valid' do
      before { post '/projects', params: valid_attributes, headers: headers }

      it 'creates a project' do
        expect(json['title']).to eq('Learn Elm')
        expect(json['description']).to eq('Igogo')
        expect(json['created_by']).to eq(user.id.to_s)
        expect(json['likes']).to eq(5)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/projects', params: { },  headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("Validation failed: Title can't be blank, Description can't be blank, Likes can't be blank")
      end
    end
  end

  describe 'PUT /projects/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/projects/#{project_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /projects/:id' do
    before { delete "/projects/#{project_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
