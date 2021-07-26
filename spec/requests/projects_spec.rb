require 'rails_helper'
include RequestSpecHelper

RSpec.describe 'Project API', type: :request do
    let(:name) { "test name" }
  let!(:projects) { create_list(:project, 10) }
  let(:project_id) { projects.first.id }

  describe 'GET /projects' do
    before { get '/projects' }

    it 'returns projects' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /projects/:id' do
    before { get "/projects/#{project_id}" }

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
      { title: 'Learn Elm', description: 'Igogo', images: ['img1.png', 'img2.png'], created_by: '1', likes: 5.to_s }.to_json
    end 

    context 'when the request is valid' do
      before { post '/projects', params: { title: 'Learn Elm', description: 'Igogo', images: 'img1.png', likes: 5, created_by: '1' } }

      it 'creates a project' do
        expect(json['title']).to eq('Learn Elm')
        expect(json['description']).to eq('Igogo')
        expect(json['created_by']).to eq('1')
        expect(json['likes']).to eq(5)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/projects', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("Validation failed: Description can't be blank, Created by can't be blank, Likes can't be blank")
      end
    end
  end

  describe 'PUT /projects/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/projects/#{project_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /projects/:id' do
    before { delete "/projects/#{project_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end