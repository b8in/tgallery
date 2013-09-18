class EHistory < ActiveRecord::Base
  attr_accessible :date, :event_id, :eventable

  belongs_to :user
  belongs_to :event

  #belongs_to :like, dependent: :destroy #delete перекрестное удаление
  #belongs_to :navigation, dependent: :destroy #delete
  #belongs_to :user_comment, dependent: :destroy #delete

  belongs_to :eventable, polymorphic: true

  paginates_per 15

  validates :date,
            presence: true
  validates :user_id,
            presence: true,
            numericality: { only_integer: true }
  validates :event_id,
            presence: true,
            numericality: { only_integer: true }
end
