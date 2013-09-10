class Event < ActiveRecord::Base
  attr_accessible :name

  has_many :e_histories, dependent: :destroy
end
