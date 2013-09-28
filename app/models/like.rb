class Like < ActiveRecord::Base
   attr_accessible :g_image_id, :g_image

  #has_one :e_history, dependent: :destroy   # под вопросом можно ли так
   has_one :e_history, as: :eventable, dependent: :destroy  # под вопросом можно ли так
   belongs_to :g_image, counter_cache: true

  validates :g_image_id,
            presence: true,
            numericality: { only_integer: true }
end
