class Event < ActiveRecord::Base
  attr_accessible :name

  has_many :e_histories, dependent: :destroy
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false},
            length: { in: 2..60 }
end
