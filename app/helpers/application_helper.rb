module ApplicationHelper

  def back_link(url = nil)
    link_to ('&larr; ' + t('.back')).html_safe, url || root_path
  end

end
