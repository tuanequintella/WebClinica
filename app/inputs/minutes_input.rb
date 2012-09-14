class MinutesInput < SimpleForm::Inputs::Base
  def input
    "#{@builder.text_field(attribute_name, input_html_options)} minutos".html_safe
  end
end

