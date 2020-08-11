class Event < ApplicationRecord
  validates :start_date, 
    presence: true
    #impossible de créer un évent ou modif un évent du passé

  validates :duration, 
    presence: true
    #multiple de 5 et sup à 0

  validates :title, 
    presence: true, 
    length: { in: 5..140 }

  validates :description, 
    presence: true,
    length: { in: 20..1000 }

  validates :price, 
    presence: true,
    length: { in: 1..1000 }

  validates :location, 
    presence: true

  has_many :attendances
  has_many :users, through: :attendances
end
