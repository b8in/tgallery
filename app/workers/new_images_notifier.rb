class NewImagesNiotifier
  @queue = :images_notifier

  def self.perform
    updated_categories_ids = GImageCategory.where("updated_at > :time", time: 24.hours.ago).pluck(:id)
    users = User.select(['users.id', :name, :email]).joins(:watching_categories).includes(:g_image_categories).
            where('watching_categories.g_image_category_id' => updated_categories_ids).uniq
    users.each do |user|
      UserWatchCategory.send_notification_email(user.g_image_categories, user.name, user.email).deliver
    end
    puts "Finish"
  end
end