module ApplicationHelper

  def title(title)
   	content_tag(:h1, title, :class => 'page_title')
  end

  def flash_messages
    return if flash.empty?

    content_tag(:div, :class => 'container') do
      flash.collect do |type, message|
        content_tag(:div, message, :class => "alert alert-#{type}")
      end.join("\n").html_safe
    end
  end

end
