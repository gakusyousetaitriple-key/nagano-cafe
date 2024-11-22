class Admin::OrderDetailsController < ApplicationController

  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    order = order_detail.order
    if params[:order_detail][:is_production] == "in_production"
       order.update(is_order:"in_production")
    end
    if is_all_order_details_completed(order)
      order.update(is_order: 'shipping_preparation')
    end
    flash[:notice] = "更新されました。"
    redirect_to admin_order_path(order_detail.order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :is_production)
  end

  def is_all_order_details_completed(order)
    order.order_details.each do |order_detail|
      if order_detail.is_production != 'completed'
        return false
      end
    end
    return true
  end

end
