module ApplicationHelper
  def flash_class(type)
    case type
    when :alert
      "alert-danger"
    when :notice
      "alert-success"
    else
      ""
    end
  end

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Blocipedia"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
