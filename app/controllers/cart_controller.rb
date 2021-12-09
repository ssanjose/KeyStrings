class CartController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @items = Kaminari.paginate_array(Item.find(session[:shopping_cart])).page(params[:page]).per(10)
    render "items/index" and return
  end

  # POST /cart
  def create
    logger.debug("Adding #{params[:id]} to cart.")

    id = params[:id].to_i
    title = params[:title].to_s
    session[:shopping_cart] << id

    flash[:notice] = "#{title} added to cart!"
    redirect_to root_path
  end

  # DELETE /cart/:id
  def destroy
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    flash[:notice] = " #{Item.find(id).title} removed from cart."
    redirect_to root_path
  end
end
