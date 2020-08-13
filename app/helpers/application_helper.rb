module ApplicationHelper
  def full_title page_title
    base_title = t "base_title"
    page_title.blank? ? base_title : [page_title, base_title].join(" | ")
  end

  def check_page? page
    page.left_outer? || page.right_outer? || page.inside_window?
  end

  def page_was_truncated? page
    !page.was_truncated?
  end
end
