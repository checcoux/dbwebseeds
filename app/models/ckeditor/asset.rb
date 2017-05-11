# generico contenuto di ckeditor, potrà specializzarsi in attachment o picture

class Ckeditor::Asset < ActiveRecord::Base
  include Ckeditor::Orm::ActiveRecord::AssetBase
  include Ckeditor::Backend::Paperclip
end
