class GImage < ActiveRecord::Base
  attr_accessible :name, :image
  belongs_to :g_image_category, touch: true
  has_many :likes, dependent: :destroy
  has_many :user_comments, dependent: :destroy

  mount_uploader :image, ImageUploader
  paginates_per 5

  after_create :send_email_to_subscribed_user

  scope :only_with_category, -> { where("g_image_category_id IS NOT NULL") }

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: true}
  validates :image,
            presence: true
  validates :likes_count,
            presence: true,
            numericality: { only_integer: true}
  validates :user_comments_count,
            presence: true,
            numericality: { only_integer: true}

  protected
  def send_email_to_subscribed_user
    #Resque.enqueue(UserNiotifierWorker, self.id)
    Resque.enqueue(NewImagesNiotifier)
  end

end
