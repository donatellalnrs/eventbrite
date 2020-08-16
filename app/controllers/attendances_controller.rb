class AttendancesController < EventsController
  def index 
    @attendances = Attendance.where(event_id: params[:event_id])
  end 
  
  def new
    @attendance = Attendance.new
    @event = Event.find(params[:event_id]) 
    @amount = @event.price 
  end
  
  def create
    @amount = Event.find(params[:event_id]).price * 100

    unless @amount == 0
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
        id: params[:stripeId],
      })
  
      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @amount,
        description: 'Rails Stripe customer',
        currency: 'eur',
      })

    Attendance.create(event_id: params[:event_id], user_id: current_user.id, stripe_customer_id: params[:stripeToken])

    else 
      Attendance.create(event_id: params[:event_id], user_id: current_user.id, stripe_customer_id: "azerty")
    end 

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
