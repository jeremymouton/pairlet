module ApplicationHelper

  def title(title)
   	content_tag(:h1, title, :class => 'page_title')
  end

  def flash_messages
    return if flash.empty?

    content_tag(:div, :class => 'notification') do
      flash.collect do |type, message|
        content_tag(:div, :class => "alert alert-#{type}") do
          raw(message) +
          content_tag(:button, raw('&times;'), :class => 'close', :type => 'button', :data => { :dismiss => 'alert'})
        end

      end.join("\n").html_safe
    end
  end

end
