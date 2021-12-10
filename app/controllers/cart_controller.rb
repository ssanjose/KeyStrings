class CartController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @carts = if session[:shopping_cart].count.positive?
               Kaminari.paginate_array(Item.find(session[:shopping_cart].map do |item|
                                                   item["id"]
                                                 end)).page(params[:page])
             else
               []
             end

    render "cart/index" and return
  end

  # POST /cart
  def create
    item = Item.find(params[:id])
    logger.debug("Adding #{item.title} to cart.")

    session[:shopping_cart] << { id: item.id, qty: 1 }

    flash[:notice] = "#{item.title} added to cart!"
    redirect_back(fallback_location: root_path)
  end

  # DELETE /cart/:id
  def destroy
    session[:shopping_cart].delete_if { |item| item["id"].to_i == params[:id].to_i }

    session[:shopping_cart] = [] if session[:shopping_cart].count == 0
    flash[:notice] = " #{Item.find(params[:id]).title} removed from cart."
    redirect_back(fallback_location: root_path)
  end

  # POST /cart/buy/:id
  def buy
    id = params[:id].to_i
    title = params[:title].to_s
    session[:shopping_cart] << id

    flash[:notice] = "#{title} added to cart!"
    redirect_to cart_index_path
  end

  def add
    session[:shopping_cart].each do |item|
      item["qty"] += 1 if item["id"].to_i == params[:id].to_i
    end
    redirect_back(fallback_location: root_path)
  end

  def subtract
    session[:shopping_cart].each do |item|
      item["qty"] -= 1 if item["id"].to_i == params[:id].to_i
    end
    redirect_back(fallback_location: root_path)
  end
end
