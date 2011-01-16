module ApplicationHelper
  def controller_stylesheet_link_tag
    stylesheet = "#{params[:controller]}.css"
        
    if File.exists?(File.join(Rails.public_path, 'stylesheets', stylesheet))
      stylesheet_link_tag stylesheet
    end
  end

  def controller_javascript_include_tag
    javascript = "#{params[:controller]}.js"

    javascript_include_tag javascript if File.exists?(File.join(Rails.public_path, 'javascripts', javascript))
  end
end
