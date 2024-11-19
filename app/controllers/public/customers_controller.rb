module Public
  class CustomersController < ApplicationController
    def show
      @customer = Customer.find(current_customer.id)
    end

    def edit
      @customer = Customer.find(current_customer.id)
    end

    def update
      @customer = Customer.find(current_customer.id)
      @customer.update(customer_params)
      redirect_to my_page_public_customer_path(@customer)
    end

    def unsubscribe
    end

    def withdraw
      @customer = Customer.find(current_customer.id)
      @customer.skip_email_changed_notification!
      unique_email = "deleted_" + Time.now.to_i.to_s + "/" + @customer.email
      @customer.update(email: unique_email, is_active: false)
      reset_session
      flash[:notice] = "退会処理を実行いたしました"
      redirect_to top_path
    end

    private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :email, :address, :telephone_number, :post_code)
    end
  end
end