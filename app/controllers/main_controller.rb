class MainController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @items = Item.all.page(params[:page])

    render "items/index" and return
  end
end
