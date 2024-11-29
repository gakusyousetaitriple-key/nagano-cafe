class ApplicationController < ActionController::Base
  # app/controllers/admin/application_controller.rb
  before_action :authenticate_admin!, if: :admin_url   # ログインを必須にする

  def admin_url
    request.fullpath.include?("/admin")
  end
end