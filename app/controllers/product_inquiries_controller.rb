class ProductInquiriesController < ApplicationController

  before_filter :find_page, :only => [:create, :new]

  def thank_you
    @page = Page.find_by_link_url("/product_inquiry_thank_you", :include => [:parts, :slugs])
  end

  def new
    @product_inquiry = ProductInquiry.new(params[:product_inquiry])
    @product_inquiry.product_id = params[:product_id] if params[:product_id].present?
  end

  def create
    @product_inquiry = ProductInquiry.new(params[:product_inquiry])

    if @product_inquiry.save
      if @product_inquiry.ham?
        begin
          ProductInquiryMailer.notification(@product_inquiry, request).deliver
        rescue
          logger.warn "There was an error delivering an inquiry notification.\n#{$!}\n"
        end
      end

      redirect_to product_inquiry_thank_you_path
    else
      render :action => 'new'
    end
  end
  protected

  def find_page
    @page = Page.where(:link_url => "/product_inquiry").first
  end

end
