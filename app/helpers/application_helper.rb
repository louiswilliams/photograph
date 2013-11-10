module ApplicationHelper
  def flash_block
    output = ''
    flash.each do |type, message|
      output += flash_container(type, message)
    end

    raw(output)
  end

  def flash_container(type, message)
    type = (type.eql? "alert") ? "danger" : type
    type = (type.eql? "notice") ? "success" : type
    raw(content_tag(:div, :class => "alert alert-#{type}") do
      content_tag(:a, raw("&times;"),:class => 'close', :data => {:dismiss => 'alert'}) +
      message
    end)
  end

end
