class EHistory < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :date, :event_id

  belongs_to :user
  belongs_to :event

  belongs_to :like, dependent: :destroy #delete перекрестное удаление
  belongs_to :navigation, dependent: :destroy #delete
  belongs_to :user_comment, dependent: :destroy #delete

end
