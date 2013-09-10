class EHistory < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :date, :event_id

  belongs_to :user
  belongs_to :event
end
