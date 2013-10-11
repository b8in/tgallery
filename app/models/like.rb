class Like < ActiveRecord::Base
   attr_accessible :g_image_id, :g_image

   has_one :e_history, as: :eventable, dependent: :destroy
   belongs_to :g_image, counter_cache: true

  validates :g_image_id,
            presence: true,
            numericality: { only_integer: true }
end
