class ItemsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @items = Item.all.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def search
    if params[:search].blank?
      redirect_to root_path and return
    else
      @parameter = params[:search].downcase
      @items = Item.all.where("lower(title) LIKE :search",
                              search: "%#{@parameter}%").page(params[:page])
    end
  end
end
