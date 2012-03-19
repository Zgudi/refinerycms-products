class ApplicationController < ActionController::Base

  before_filter :initialize_cart

  def after_sign_in_path_for(resource)
    if @current_cart.blank?
      @current_cart = get_cart
    end

    @current_cart.customer_id = current_customer.id
    @current_cart.save

    stored_location_for(resource) || category_products_path(1)
  end
  
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_udpate_path_for(resource)
    profiles_path
  end
        
  def initialize_cart
    @current_cart = get_cart
  end

  # Get the current customer's cart
  def get_cart
      if customer_signed_in?
          
          if session[:cart_id].present?
              cart = Cart.find(session[:cart_id])
              if cart.customer_id.blank?
                  cart.customer_id = current_customer.id
                  cart.is_current = true
                  cart.save
              end
              return cart
          else
              cart = Cart.where(:is_current => true, :customer_id => current_customer.id).first
              if cart.blank?
                  cart = Cart.create(:is_current => true, :customer_id => current_customer.id)
              end
              
              session[:cart_id] = cart.id
              return cart
          end
          
      else
          if session[:cart_id].present?
              # logger.info("*************** signed OUT and session was present")
              cart = Cart.find_by_id(session[:cart_id])
              if cart.blank?
                  cart = Cart.create(:is_current => true)
                  session[:cart_id] = cart.id
                  return cart
              else
                  cart.is_current = true
                  cart.save
                  return cart
              end
          else
              # logger.info("*************** signed OUT and session was NOT present")
              cart = Cart.create(:is_current => true)
              session[:cart_id] = cart.id
              return cart
          end
      end
  end
end