class GImageCategory < ActiveRecord::Base
  #new picture add by rake_task. From Ctrl cannt create category
  #attr_accessible :name
  has_many :g_images
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false},
            length: { in: 2..60 }

  paginates_per 12
end
