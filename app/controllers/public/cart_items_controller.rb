class Public::CartItemsController < ApplicationController
  # カート内一覧表示
  def index
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum { |item| item.quantity * item.item.price }
  end

  # カートに商品を追加
  def create
    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item
      @cart_item.quantity += params[:cart_item][:quantity].to_i
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
    end

    if @cart_item.save
      redirect_to public_cart_items_path, notice: '商品をカートに追加しました。'
    else
      redirect_to public_item_path(params[:cart_item][:item_id]), alert: 'カート追加に失敗しました。'
    end
  end

  # カート内商品の個数を変更
  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to public_cart_items_path, notice: 'カートを更新しました。'
    else
      redirect_to public_cart_items_path, alert: '更新に失敗しました。'
    end
  end

  # 特定のカート内商品を削除
  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path, notice: '商品を削除しました。'
  end

  # カートを空にする
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path, notice: 'カートを空にしました。'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end
end
