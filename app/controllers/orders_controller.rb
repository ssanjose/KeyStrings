class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def create
    puts "start order create"
    order = current_user.orders.create(
      price:       params[:price].to_d,
      pst:         params[:pst].to_d,
      gst:         params[:gst].to_d,
      created:     Date.new,
      running:     true,
      discount_id: Discount.first.id
    )

    # unless order.valid?
    #   # for each column check for errors:
    #   order.errors.messages.each do |column, errors|
    #     # for each message ON each column:
    #     errors.each do |error|
    #       puts "ERROR: #{column} #{error}"
    #     end
    #   end
    # end

    cart ||= session[:cart]
    qty_array ||= session[:qty_array]
    order_sub ||= session[:order_sub]
    unless order.nil?
      cart.each_with_index do |item, index|
        order.order_histories.create(
          quantity: qty_array[index].to_i,
          price:    order_sub[index].to_d / qty_array[index].to_d,
          item_id:  item["id"].to_i
        )
      end
    end

    flash[:notice] = "Order created!"
    session[:shopping_cart] = []

    redirect_to root_path
  end

  def show
    @order = Order.find(params[:id])
  end

  def review
    @order_sub = []
    @carts = if session[:shopping_cart].count.positive?
               Item.find(session[:shopping_cart].map { |item| item["id"] })
             else
               []
             end

    if @carts.count.positive? || @carts != []
      session[:cart] = @carts

      @qty_array = session[:shopping_cart].map { |item| item["qty"].to_i }

      @order_sub = (@carts.map.with_index { |item, index| item.price * @qty_array[index].to_i })
      if current_user
        @order_pst = @order_sub.sum * current_user.province.pst
        @order_gst = @order_sub.sum * current_user.province.gst
        @order_taxes = @order_gst + @order_pst
      end
      session[:qty_array] = @qty_array
      session[:order_sub] = @order_sub

      @order_total = @order_sub.sum + @order_taxes if current_user
    end
  end
end
