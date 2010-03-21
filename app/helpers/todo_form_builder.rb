class TodoFormBuilder < ActionView::Helpers::FormBuilder
  [:text_field, :text_area, :password_field, :datetime_select].each do |field_type|
    # Keep an alias to the original so we can refer to them in specialised versions of the standard helpers
    alias_method "orig_#{field_type}", field_type
    src_to_eval = <<-end_src
      def #{field_type}(field, options = {})
        options = options.dup
        options_for_wrapper = [:field_suffix, :is_mandatory, :label, :label_class, :wrapper_class]
        wrapper_options = options.slice(*options_for_wrapper)
        options.except!(*options_for_wrapper)
        options = set_default_options_for_field_type(:#{field_type}, options)
        field_type_wrapper(super, field, wrapper_options)
      end
    end_src

    class_eval src_to_eval, __FILE__, __LINE__
  end

  alias :original_check_box :check_box
  def check_box(field, options = {}, checked_value = "1", unchecked_value = "0")
    options = options.dup
    label = label(field, options.delete(:label), :class => options.delete(:label_class))
    label += @template.mandatory_field() if options.delete(:is_mandatory)
    wrapper_class = add_css_class(options.delete(:wrapper_class), 'form_field')
    @template.content_tag(:p, label + '&nbsp;' + super, :class => wrapper_class)
  end

  def number_field(field, options = {})
    number_options = { :size => 2 }
    text_field(field, number_options.merge(options))
  end

  alias :original_file_field :file_field
  def file_field(field, options = {})
    options = options.dup
    wrapper_class = add_css_class(options.delete(:wrapper_class), 'form_field')
    body = ''
    if options[:preview_content]
       body << options.delete(:preview_content)
       wrapper_class = add_css_class(wrapper_class, 'clearfix')
    end
    body << label(field, options.delete(:label), :class => options.delete(:label_class))
    body << @template.mandatory_field() if options.delete(:is_mandatory)
    body << "<br/>\n" + super
    @template.content_tag(:p, body, :class => wrapper_class)
  end

  def image_file_field(field, options = {})
    options = options.dup
    if object.send(field).file?
      options[:preview_content] = @template.image_tag( object.send(field).url(:thumbnail), :class => "thumbnail" )
    end
    file_field(field, options)
  end

  private

  def set_default_options_for_field_type(field_type, options)
    if options[:class]
      options[:class] += ' widget_field'
    else
      options[:class] = 'widget_field'
    end

    default_options = {}
    if field_type == :text_field
      default_options[:size] = 80
    end
    if field_type == :text_area
      default_options[:cols] = 80
    end
    default_options.merge(options)
  end

  def field_type_wrapper(result_from_super, field, options = {})
    options = options.dup
    wrapper_class = add_css_class(options.delete(:wrapper_class), 'form_field')
    field_suffix = options.delete(:field_suffix)
    body = ''
    body << label(field, options.delete(:label), :class => options.delete(:label_class))
    body << @template.mandatory_field() if options.delete(:is_mandatory)
    body << "<br/>\n" + result_from_super
    body << ' ' + field_suffix if field_suffix
    @template.content_tag(:p, body, :class => wrapper_class)
  end

  def add_css_class(classes, new_class)
    classes ||= ''
    classes += " #{new_class}"
    classes.strip
  end
end
