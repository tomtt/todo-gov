require 'rails_generator/generators/components/controller/controller_generator'

class WidgetGenerator < Rails::Generator::NamedBase

  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_path, "#{class_name}Controller", "#{class_name}Helper"

      # Controller, helper, views, and spec directories.
      m.directory File.join('app/controllers/widgets', class_path)
      m.directory File.join('app/helpers/widgets', class_path)
      m.directory File.join('app/views/widgets', class_path, file_name)

      @default_file_extension = "html.haml"

      # Controller spec, class, and helper.
      m.template 'controller.rb',
        File.join('app/controllers/widgets', class_path, "#{file_name}_controller.rb")

      m.template 'helper.rb',
        File.join('app/helpers/widgets', class_path, "#{file_name}_helper.rb")

      # Spec and view template for each action.
      m.template "create.#{@default_file_extension}",
        File.join("app/views/widgets", class_path, file_name, "create.#{@default_file_extension}")
      m.template "_entry_point.#{@default_file_extension}",
        File.join("app/views/widgets", class_path, file_name, "_entry_point.#{@default_file_extension}")
      m.template "_form.#{@default_file_extension}",
        File.join("app/views/widgets", class_path, file_name, "_form.#{@default_file_extension}")
    end
  end
end
