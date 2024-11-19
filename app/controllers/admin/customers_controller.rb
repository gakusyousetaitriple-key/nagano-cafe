class Admin::CustomersController < ApplicationController
  def index
    @customers=Customer.all
  end

  def show
    @customer=Customer.find(params[:id])
  end

  def edit
    @customer=Customer.find(params[:id])
  end
  
  def update
    @customer=Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(@customer)
  end
  
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :email, :address, :telephone_number, :post_code, :is_active)
  end
end
