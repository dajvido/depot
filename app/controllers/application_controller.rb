class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_date
  
  def set_date
    @date_now = Time.now
  end

  private
    def current_cart
      Cart.find(session[:cart_id])
    rescue ActivityRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart 
    end
end
