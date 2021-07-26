class CommentsController < ApplicationController
  before_action :set_project
  before_action :set_project_comment, only: [:show, :update, :destroy]

  def index
    json_response(@project.comments)
  end

  def show
    json_response(@comment)
  end

  def create
    @project.comments.create!(comment_params)
    json_response(@project, :created)
  end

  def update
    @comment.update(comment_params)
    head :no_content
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.permit(:content, :likes)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_project_comment
    @comment = @project.comments.find_by!(id: params[:id]) if @project
  end
end
