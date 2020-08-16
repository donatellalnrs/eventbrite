class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @administrator = User.find(@event.administrator_id)
    @attendants = Attendance.where(event_id: @event.id).count 
  end

  def new 
    @event = Event.new
    @user = current_user
  end 

  def create 
    @event = Event.new(post_params)
    @event.administrator_id = current_user.id
    if @event.save # essaie de sauvegarder en base @gossip
      Attendance.create(event_id: @event.id, user_id: current_user.id, stripe_customer_id: "azerty")
      redirect_to home_path
    else
      render :new
    end
  end 

  def edit
    @event = Event.find(params[:id]) 
  end 

  def update 
    @event = Event.find(params[:id])
    if @event.update(post_params)
      redirect_to event_path(@event.id)
    else
      render :edit
    end
  end 

  def destroy
    @event = Event.find(params[:id]) 
    @event.destroy 
    redirect_to events_path
  end 

  def post_params
    post_params = params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end 

  def correct_user
    unless current_user.id == Event.find(params[:id])[:administrator_id]
      flash[:danger] = "Vous ne pouvez pas réaliser cette action !"
      redirect_to events_path
    end 
  end 

end
