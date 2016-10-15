class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def ckeditor_pictures_scope(options = { :assetable_id => params[:column_id], :assetable_type => "Column"})
    # options = { :assetable_id => params[:column_id], :assetable_type => "Column"}
    ckeditor_filebrowser_scope(options)
  end

  def ckeditor_attachment_files_scope(options = { :assetable_id => "#{current_page.id}" ,:assetable_type => "Page" })
    # options = { :assetable_id => params[:column_id], :assetable_type => "Column"}
    ckeditor_filebrowser_scope(options)
  end


  def ckeditor_before_create_asset(asset)
    # logger.debug "colonna da create: " + params[:column_id]
    asset.assetable = Column.find(params[:column_id])
    return true
  end

  private

  def user_not_authorized
    flash[:alert] = "Non autorizzato."
    redirect_to(request.referrer || home_path )
  end
end
