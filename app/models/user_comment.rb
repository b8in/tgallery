class UserComment < ActiveRecord::Base
   attr_accessible :text, :e_history_id, :g_image_id

  belongs_to :user
  belongs_to :g_image
  has_one :e_history, dependent: :destroy
end
