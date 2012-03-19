class CartsController < ApplicationController

  before_filter :initialize_cart

  def add_to_cart
    check_quantity_then_update_cart

      # redirect_to_products("Product added to Cart")
    redirect_to show_cart_path
  end

  # Here for backwards compatibility
  def show_cart
    render :action => 'show'
  end

  def show

  end
  
  def check_quantity_then_update_cart 

    #logger.info("****************** the variant = #{params[:variant][:id]}")
  
    if params[:quantity].present?
      if params[:variant].present?
        @current_cart.add_to_the_cart(params[:product_id], params[:quantity], params[:variant][:id])
      else
        @current_cart.add_to_the_cart(params[:product_id], params[:quantity])
      end    
    else
      if params[:variant].present?
        @current_cart.add_to_the_cart(params[:product_id], 1, params[:variant][:id])
      else
        @current_cart.add_to_the_cart(params[:product_id])
      end
    end
    
  end
    
  def increment_cart
    check_quantity_then_update_cart
    
    redirect_to show_cart_path
  end
    
  private
  
  def redirect_to_products(msg)
      flash[:notice] = msg
      
      if params[:category_id].present?
        if params[:category_id] == "0"
          redirect_to "/"
        else
          redirect_to category_products_path(params[:category_id])
        end    
      else
        redirect_to product_path(params[:product_id])
      end          
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
