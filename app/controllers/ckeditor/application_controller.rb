class Ckeditor::ApplicationController < Ckeditor.parent_controller.constantize
  # layout Ckeditor.controller_layout # (per versione 4.2.1)
  layout 'ckeditor/application' # (per versione 4.2.0)

  before_action :find_asset, :only => [:destroy]
  before_action :ckeditor_authorize!
  before_action :authorize_resource

  protected

  def respond_with_asset(asset)
    asset_response = Ckeditor::AssetResponse.new(asset, request)
    _callback = ckeditor_before_create_asset(asset)

    if _callback && asset.save
      render asset_response.success(config.relative_url_root)
    else
      render asset_response.errors
    end
  end

  def ckeditor_pictures_scope(options = { :assetable_id => params[:column_id], :assetable_type => "Column"})
    ckeditor_filebrowser_scope(options)
  end

  def ckeditor_attachment_files_scope(options = { })
    ckeditor_filebrowser_scope(options)
  end


  def ckeditor_before_create_asset(asset)
    # logger.debug "colonna da create: " + params[:column_id]
    asset.assetable = Column.find(params[:column_id])
    return true
  end

end