class Navigation < ActiveRecord::Base
  attr_accessible :target_url, :e_history_id

  #has_one :e_history
  has_one :e_history, as: :eventable, dependent: :destroy
end
