class Admin::ProductInquiriesController < Admin::BaseController

  crudify :product_inquiry, :title_attribute => "name", :order => "created_at DESC"
  helper_method :group_by_date

  before_filter :find_all_ham, :only => [:index]
  before_filter :find_all_spam, :only => [:spam]
  before_filter :get_spam_count, :only => [:index, :spam]

  def index
    @inquiries = @inquiries.with_query(params[:search]) if searching?
    @inquiries = @inquiries.paginate({:page => params[:page]})
  end

  def spam
    self.index
    render :action => 'index'
  end

  def toggle_spam
    find_inquiry
    @inquiry.toggle!(:spam)

    redirect_to :back
  end

  protected

  def find_all_ham
    @inquiries = ProductInquiry.ham
  end

  def find_all_spam
    @inquiries = ProductInquiry.spam
  end

  def get_spam_count
    @spam_count = ProductInquiry.count(:conditions => {:spam => true})
  end

end