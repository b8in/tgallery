class HomesController < ApplicationController

  def change_locale
    if ['ru', 'en'].include?(params[:new_locale])
      I18n.locale = params[:new_locale]
    else
      I18n.locale = I18n.default_locale
    end
    redirect_to params[:back_url]
  end

  def index
    @categories = GImageCategory.includes(:g_images).reverse_order.limit(6)
    @comments = UserComment.includes(e_history: [:user], g_image: [:g_image_category]).order(:created_at).reverse_order.limit(5)

    gon.pusher_config = Webs.pusher_config
  end

end
