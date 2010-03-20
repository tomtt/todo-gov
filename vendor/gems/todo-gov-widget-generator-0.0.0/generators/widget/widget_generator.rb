require 'rails_generator/generators/components/controller/controller_generator'

class WidgetGenerator < Rails::Generator::NamedBase

  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_path, "#{class_name}Controller", "#{class_name}Helper"

      # Controller, helper, views, and spec directories.
      m.directory File.join('app/controllers', class_path)
      m.directory File.join('app/controllers/widgets', class_path)
      m.directory File.join('app/helpers', class_path)
      m.directory File.join('app/helpers/widgets', class_path)
      m.directory File.join('app/views', class_path, file_name)
      m.directory File.join('app/views/widgets', class_path, file_name)

      @default_file_extension = "html.haml"

      # Controller spec, class, and helper.
      m.template 'controller.rb',
        File.join('app/controllers/widgets', class_path, "#{file_name}_controller.rb")

      m.template 'controller:helper.rb',
        File.join('app/helpers/widgets', class_path, "#{file_name}_helper.rb")

      # Spec and view template for each action.
      actions.each do |action|
        path = File.join('app/views/widgets', class_path, file_name, "#{action}.#{@default_file_extension}")
        m.template "controller:view.#{@default_file_extension}",
          path,
          :assigns => { :action => action, :path => path }
      end
    end
  end
end
