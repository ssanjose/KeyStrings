class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!

  helper_method :search

  def index
    @categories = Category.all

    if session[:picked_categories].count > 0
      @items = Kaminari.paginate_array(Item.all.where(category_id: session[:picked_categories])).page(params[:page])
    else
      @items = Item.all.page(params[:page])
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def search
    session[:picked_categories] << params[:id].to_i

    redirect_to categories_path and return
  end

  def destroy_picks
    session[:picked_categories] = []
    redirect_to categories_path and return
  end
end
