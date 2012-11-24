module ApplicationHelper

  def flash_messages
    return if flash.empty?

    content_tag(:div, :class => 'container') do
      flash.collect do |type, message|
        content_tag(:div, message, :class => "alert alert-#{type}")
      end.join("\n").html_safe
    end
  end

end
