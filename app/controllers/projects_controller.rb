class ProjectsController < ApplicationController
    before_action :set_project, only: [:show, :update, :destroy]

  def index
    @projects = Project.all
    json_response(@projects)
  end

  def create
    @project = Project.create!(project_params)
    json_response(@project, :created)
  end

  def show
    json_response(@project)
  end

  def update
    @project.update(project_params)
    head :no_content
  end

  def destroy
    @project.destroy
    head :no_content
  end

  private

  def project_params
    params.permit(:title, :description, :images, :created_by, :likes)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
