class GImageCategory < ActiveRecord::Base
  #new picture add by rake_task. From Ctrl cannt create category
  #attr_accessible :name
  has_many :paintings, dependent: :destroy

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false},
            length: { in: 2..60 }
end
