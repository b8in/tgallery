class UserComment < ActiveRecord::Base
   attr_accessible :text, :g_image_id, :g_image

  has_one :user, through: :e_history
  belongs_to :g_image, counter_cache: true
  has_one :e_history, as: :eventable, dependent: :destroy

  validates :text,
            presence: true,
            length: { in: 2..250 }
  validates :g_image_id,
            presence: true,
            numericality: { only_integer: true }

end
