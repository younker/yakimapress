class ApplicationController < ActionController::Base
  # include Younker::SslRequirement

  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  # make these available to the views
  helper_method :encrypt, :decrypt

  def layout
    request.xhr? ? false : 'application'
  end

  def render_404
    @frame = nil
    @active_section = nil
    render :template => 'shared/exceptions/404.haml', :status => '404'
  end
  
  def redirect_unless_admin
    unless user_signed_in? && current_user.admin?
      flash[:error] = 'You are not permitted to view that page.'
      redirect_to (request.env["HTTP_REFERER"].present? ? request.env["HTTP_REFERER"] : root_path)
    end
  end

  def encrypt(*args)
    YAML::dump(args).encrypt(:symmetric, :password => KEYS['encryption']['password'])
  end
  
  def decrypt(str)
    YAML::load(str.decrypt(:symmetric, :password => KEYS['encryption']['password']))
  end

  # Rules
  # 1. the 'path' parameter is the ONLY parameter we accept. The main function of this is to weed out tracking
  #    parameters. This means we construct canonical paths using a white list (things we accept, i.e. page) and not a
  #    black list (things we do not accept, i.e. YSMKEY). This may introduce a maintenance nightmare going forward as
  #    any new accepted parameter will have to be added to this. However, for the foreseeable future, pagination is
  #    the only instance where params should be passed. In all other cases, params should be passed in the path itself
  # 2. Page 1 of any paginated page is actually the page itself, so no page param is needed
  def canonical_path
    # root_url ends in a slash, request.path starts with one, we need to strip one of them out!
    url = "#{root_url.gsub(/\/$/,'')}#{request.path}"

    # rule #1 && rule #2
    if params['page'] && params['page'].to_i != 1
      url = url + "?page=#{params[:page]}"
    end

    url
  end

end
