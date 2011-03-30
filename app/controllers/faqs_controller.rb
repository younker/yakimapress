class FaqsController < InheritedResources::Base
  before_filter :redirect_unless_admin, :except => [:index, :show]

  before_filter :set_faq, :except => [:index, :new, :create]
  before_filter :set_canonical, :only => [:show]

  include FaqsHelper

  def create
    create! do |format|
      format.html { redirect_to faq_path(@faq.permalink) }
    end
  end

  def update
    update! do |format|
      format.html { redirect_to faq_path(@faq.permalink) }
    end
  end
  
  def set_faq
    @faq = Faq.find_by_permalink(params['id']) || Faq.find_by_id(params['id'])
  end

  def set_canonical
    @canonical = faq_url(@faq.permalink) unless faq_path(@faq.permalink) == request.path
  end
end
