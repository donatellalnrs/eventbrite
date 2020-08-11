class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @administrator = User.find(@event.administrator_id)
  end

  def new 
    @event = Event.new
    @user = current_user
  end 

  def create 
    @event = Event.new(post_params)
    @event.administrator_id = current_user.id
    if @event.save # essaie de sauvegarder en base @gossip
      redirect_to home_path
    else
      render :new
    end
  end 

  def post_params
    post_params = params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end 
end
