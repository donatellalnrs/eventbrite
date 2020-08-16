class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :correct_user, only: [:show]

  def show
    @current_user = current_user
    @events_admin = Event.where(administrator_id: current_user.id)
  end

  def correct_user
    unless current_user == User.find(params[:id])
      flash[:danger] = "Vous ne pouvez pas réaliser cette action !"
      redirect_to home_path
    end 
  end 
end
