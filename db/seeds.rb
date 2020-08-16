require 'faker'
I18n.reload!

10.times do 
  my_user = User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence, email: Faker::Internet.email, encrypted_password: Faker::Internet.password)
  my_user.save
end 

20.times do 
  my_event = Event.new(start_date: Faker::Time.between(from: DateTime.now, to: DateTime.now + 700), duration: Faker::Number.between(from: 1, to: 3), title: Faker::Lorem.word, description: Faker::Lorem.sentence, price: Faker::Number.between(from: 0, to: 100), location: Faker::Address.city)
  my_event.administrator_id = rand (1..3)
  my_event.save
end 


40.times do 
  my_attendance = Attendance.new(stripe_customer_id: Faker::Number.between(from: 1, to: 10000000))
  my_attendance.user_id = rand (1..3)
  my_attendance.event_id = rand (1..20) 
  my_attendance.save
end 

