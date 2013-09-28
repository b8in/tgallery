class Navigation < ActiveRecord::Base
  attr_accessible :target_url

  has_one :e_history, as: :eventable, dependent: :destroy

  validates :target_url,
            presence: true,
            url: true
end
