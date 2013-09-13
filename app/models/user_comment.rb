class UserComment < ActiveRecord::Base
   attr_accessible :text, :e_history_id, :g_image_id

  belongs_to :user
  belongs_to :g_image, counter_cache: true
  #has_one :e_history, dependent: :destroy
   has_one :e_history, as: :eventable, dependent: :destroy
end
