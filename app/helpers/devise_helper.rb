module DeviseHelper


  def devise_error_messages!
    flash_alerts = []
    error_key = 'errors.messages.not_saved'

    if !flash.empty?
      flash_alerts.push(flash.now[:error]) if flash[:error]
      flash_alerts.push(flash.now[:alert]) if flash[:alert]
      flash_alerts.push(flash.now[:notice]) if flash[:notice]
      error_key = 'devise.failure.invalid'
    end

    return "" if resource.errors.empty? && flash_alerts.empty?
    errors = resource.errors.empty? ? flash_alerts : resource.errors.full_messages

    messages = errors.map { |msg| content_tag(:div, msg) }.join

    html = <<-HTML
    <div id="error_explanation">
      <div>#{messages}</div>
    </div>
    HTML

    html.html_safe
  end

end