class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!

  helper_method :search

  def index
    @categories = Category.all

    session[:picked_categories] ||= []
    @items = if session[:search] != "" && session[:picked_categories].count.positive?
               Kaminari.paginate_array(Item.where(category_id: session[:picked_categories])
                                           .where("lower(title) LIKE :search",
                                                  search: "%#{session[:search]}%")).page(params[:page])
             elsif session[:search] != "" && (session[:picked_categories].count <= 0)
               Kaminari.paginate_array(Item.where("lower(title) LIKE :search",
                                                  search: "%#{session[:search]}%")).page(params[:page])
             elsif session[:search] == "" && (session[:picked_categories].count <= 0)
               Kaminari.paginate_array(Item.where(category_id: session[:picked_categories])).page(params[:page])
             else
               Item.all.page(params[:page])
             end
  end

  def show
    @category = Category.find(params[:id])
  end

  def search
    session[:picked_categories] ||= []
    session[:picked_categories] << params[:id].to_i

    logger.debug("search action controller categories!")
    logger.debug("search action controller categories!")
    logger.debug("search action controller categories!")
    logger.debug("search action controller categories!")
    logger.debug("search action controller categories!")
    logger.debug("search action controller categories!")
    logger.debug("search action controller categories!")

    redirect_to categories_path and return
  end

  def destroy_picks
    session[:picked_categories] = []
    redirect_to categories_path and return
  end
end
