class Widgets::<%= class_name %>Controller < Widgets::WidgetsController
<% for action in actions -%>
  def <%= action %>
  end

<% end -%>
end
