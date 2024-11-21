class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    # 注文情報を生成
    @order = current_customer.orders.build(order_params)
  
    # お届け先を選択
    case params[:order][:address_option]
    when "0"
      # 登録済み住所を使用
      @order.address = current_customer.address
      @order.post_code = current_customer.post_code
      @order.name = "#{current_customer.last_name} #{current_customer.first_name}"
    when "1"
      # 選択した配送先住所を使用
      address = current_customer.addresses.find_by(id: params[:address_id])
      if address.nil?
        flash[:alert] = "選択した配送先が見つかりません。"
        redirect_to new_public_order_path
        return
      end
      @order.address = address.address
      @order.post_code = address.post_code
      @order.name = address.name
    when "2"
      # 新しい住所を使用
      @order.address = params[:order][:address]
      @order.post_code = params[:order][:post_code]
      @order.name = params[:order][:name]
    else
      # 無効な選択肢
      flash[:alert] = "正しいお届け先を選択してください。"
      redirect_to new_public_order_path
      return
    end
  
    # カートアイテムを取得
    @cart_items = current_customer.cart_items
  
    # 合計金額と送料を計算
    @order.postage = 800 # 一律送料
    @order.total_amount = @cart_items.sum do |cart_item|
      cart_item.item.price * cart_item.amount
    end
  end
  
  
  
  
  
  

  def create
    @order = current_customer.orders.build(order_params)
    @cart_items = current_customer.cart_items
    @order.is_order = :waiting_for_payment  # ここでステータスを設定 (例えば、最初は「支払い待ち」)
    
    @order.postage = 800
    @order.total_amount = @cart_items.sum { |cart_item| cart_item.item.price * cart_item.amount }
  
    if @order.save
      @cart_items.each do |cart_item|
        @order.order_details.create!(
          item_id: cart_item.item_id,
          price: cart_item.item.price,
          quantity: cart_item.amount,
          is_production: 'not_started' # 'your_value_here'を適切な値に変更
        )
      end
      @cart_items.destroy_all
      redirect_to url_for(controller: 'public/orders', action: 'thanks')




    else
      # エラー内容を出力
      puts "注文保存エラー: #{@order.errors.full_messages}"
      flash[:alert] = "注文の保存に失敗しました。内容を確認してください。"
      render :new
    end
  end
  

  def thanks
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private

  # order_paramsメソッドを定義して、必要なパラメータを許可
  def order_params
    params.require(:order).permit(:address, :post_code, :name, :payment_method, :total_amount, :postage, :is_order, :address_id, :address_option)
  end
  

  
end

