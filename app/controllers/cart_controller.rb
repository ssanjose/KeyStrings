class CartController < ApplicationController
  def index
    @items = Item.find(session[:shopping_cart])
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
