module ColumnsHelper
  def cropped_image image, percentage, autocrop
    if autocrop
      "<div class='cropped-#{percentage}'><img src='#{image}' class='cropped-image'></div>".html_safe
    else
      "<img src='#{image}' style='width: 100%;'>".html_safe
    end
  end
end
