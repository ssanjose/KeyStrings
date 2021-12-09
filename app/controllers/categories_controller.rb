class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!

  helper_method :search

  def index
    @categories = Category.all
    @items = Item.all.page(params[:page])

    if session[:picked_categories].count > 0
      @items = Kaminari.paginate_array(@items.where(category_id: session[:picked_categories])).page(params[:page])
    end

    render action: "index" and return
  end

  def show
    @category = Category.find(params[:id])
  end

  def search
    session[:picked_categories] << params[:id].to_i

    logger.debug(session[:picked_categories].to_s)
    redirect_to categories_path and return
  end

  def destroy_picks
    session[:picked_categories] = []
    redirect_to categories_path and return
  end
end
