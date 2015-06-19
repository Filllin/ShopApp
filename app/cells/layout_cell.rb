class LayoutCell < Cell::ViewModel

  #include Devise
  def self.helper_method(*)
  end
  include Devise::Controllers::Helpers

  #include forms
  include Ransack::Helpers::FormHelper
  include ActionView::Helpers::FormHelper

  # include assets
  include Sprockets::Rails::Helper
  self.assets_prefix = Rails.application.config.assets.prefix
  self.assets_environment = Rails.application.assets
  self.digest_assets = Rails.application.config.assets[:digest]

  def show
    if @options[:layout] == 'header'
      header
    elsif @options[:layout] == 'footer'
      footer
    elsif @options[:layout] == 'left_sidebar'
      left_sidebar
    elsif @options[:layout] == 'right_sidebar'
      right_sidebar
    end
  end

  protected
  def left_sidebar
    @categories = Category.all
    render :left_sidebar
  end

  protected
  def right_sidebar
    render :right_sidebar
  end

  protected
  def header
    @search = Product.search(params[:q])
    @products = @search.result.includes(:author, :sub_category)
    render :header
  end

  protected
  def footer
    render :footer
  end

  protected
  def dom_class(record, prefix = nil)
    ActionView::RecordIdentifier.dom_class(record, prefix)
  end

  protected
  def dom_id(record, prefix = nil)
    ActionView::RecordIdentifier.dom_id(record, prefix)
  end
end


