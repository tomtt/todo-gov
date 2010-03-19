# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def perform_button(label = 'Perform')
    submit_tag(label, :class => 'widget_perform')
  end
end
