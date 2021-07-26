class ProjectsController < ApplicationController
    before_action :set_project, only: [:show, :update, :destroy]

  def index
    @projects = current_user.projects
    json_response(@projects)
  end

  def create
    @project = current_user.projects.create!(project_params)
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
    params.permit(:title, :description, :images, :likes)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
