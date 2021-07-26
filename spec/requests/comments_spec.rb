require 'rails_helper'

RSpec.describe 'Comments API' do
  let(:name) { "test name" }
  let!(:project) { create(:project) }
  let!(:comments) { create_list(:comment, 20, project_id: project.id) }
  let(:project_id) { project.id }
  let(:id) { comments.first.id }

  describe 'GET /projects/:project_id/comments' do
    before { get "/projects/#{project_id}/comments" }

    context 'when project exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all project comments' do
        expect(json.size).to eq(20)
      end
    end

    context 'when project comment not exist' do
      let(:project_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Project/)
      end
    end
  end

  describe 'GET /projects/:project_id/comments/:id' do
    before { get "/projects/#{project_id}/comments/#{id}" }

    context 'when project comment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the comment' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when project comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  describe 'POST /projects/:project_id/comments' do
    let(:valid_attributes) { { content: 'Visit Narnia', likes: 15 } }

    context 'when request attributes are valid' do
      before { post "/projects/#{project_id}/comments", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/projects/#{project_id}/comments", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Content can't be blank/)
      end
    end
  end

  describe 'PUT /projects/:project_id/comments/:id' do
    let(:valid_attributes) { { content: 'Visit Narnia' } }

    before { put "/projects/#{project_id}/comments/#{id}", params: valid_attributes }

    context 'when comment exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the comment' do
        comment_item = Comment.find(id)
        expect(comment_item.content).to match(/Visit Narnia/)
      end
    end

    context 'when the comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  describe 'DELETE /projects/:id' do
    before { delete "/projects/#{project_id}/comments/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end