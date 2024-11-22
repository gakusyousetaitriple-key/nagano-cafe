class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
    @order_details = @order.order_details.includes(:item)
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if params[:order][:is_order] == "payment_confirmed"
      @order.order_details.update(is_production:"waiting_for_start")
    end
    flash[:notice] = "更新されました。"
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
  params.require(:order).permit(:customer_id, :is_order)
  end

end
