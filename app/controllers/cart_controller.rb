class CartController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @order_sub = 0
    @carts = if session[:shopping_cart].count.positive?
               Item.find(session[:shopping_cart].map { |item| item["id"] })
             else
               []
             end

    if @carts.count.positive? || @carts != []
      @qty_array = session[:shopping_cart].map { |item| item["qty"].to_i }

      @order_sub = (@carts.map.with_index { |item, index| item.price * @qty_array[index].to_i })
      if current_user
        @order_taxes = @order_sub.sum * (current_user.province.gst + current_user.province.pst)
      end
      @order_total = @order_sub.sum + @order_taxes if current_user
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
