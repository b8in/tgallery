class Like < ActiveRecord::Base
   attr_accessible :e_history_id, :g_image_id

  has_one :e_history, dependent: :destroy   # под вопросом можно ли так
  belongs_to :g_image, counter_cache: true
end
