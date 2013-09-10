class Navigation < ActiveRecord::Base
  attr_accessible :target_url, :e_history_id

  has_one :e_history
end
