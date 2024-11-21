class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
    @orders = Order.all.order(created_at: :desc)
  end
end
