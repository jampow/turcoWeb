module SemanticFormHelper

#<label class="w25 inputselect mandatory" for="title">
#  <span class="wrapper">
#    <span class="title">Title</span>
#    <input class="field" id="title" type="text" />
#  </span>
#</label>

#<label class="w50 radiocheck" for="chk2">
#  <span class="wrapper">
#    <input class="select" id="chk2" type="checkbox" />
#    <span class="title">Fish and chips, please!</span>
#  </span>
#</label>

#<label class="wauto radiocheck" for="yes">
#  <span class="wrapper">
#    <input class="select" id="yes" name="popmusic" type="radio" />
#    <span class="title">Yes!</span>
#  </span>
#</label>

#  def wrapping(type, field_name, label, field, options = {})
#    help = %Q{<span class="help">#{options[:help]}</span>} if options[:help]
#    to_return = []
#    to_return << %Q{<div class="#{type}-field #{options[:class]}">}
#    to_return << %Q{<label for="#{field_name}">#{label}#{help}</label>} unless ["radio","check", "submit"].include?(type)
#    to_return << %Q{<div class="input">}
#    to_return << field
#    to_return << %Q{<label for="#{field_name}">#{label}</label>} if ["radio","check"].include?(type)
#    to_return << %Q{</div></div>}
#  end

  def wrapping(type, field_name, label, field, options = {})

    klass  = ["radio","check", "submit"].include?(type) ? "radiobox" : "inputselect"
    klass += " w" + (options[:size] && [25, 50, 75, 100].include?(options[:size]) ? options[:size].to_s : "25")
    klass += " mandatory" if options[:required]

    to_return = []
    to_return << %Q{<label for="#{field_name}" class="#{klass}">}
    to_return << %Q{<span class="wrapper">}
    to_return << %Q{<span class="title">#{label}</span>} unless ["radio","check", "submit"].include?(type)
    to_return << field
    to_return << %Q{<span class="title">#{label}</span>} if ["radio","check"].include?(type)
    to_return << %Q{</span></label>}
  end

  def semantic_group(type, field_name, label, fields, options = {})
    help = %Q{<span class="help">#{options[:help]}</span>} if options[:help]
    to_return = []
    to_return << %Q{<div class="#{type}-fields #{options[:class]}">}
    to_return << %Q{<label for="#{field_name}">#{label}#{help}</label>}
    to_return << %Q{<div class="input">}
    to_return << fields.join
    to_return << %Q{</div></div>}
  end

  def boolean_field_wrapper(input, name, value, text, help = nil)
    field = []
    field << %Q{<label>#{input} #{text}</label>}
    field << %Q{<div class="help">#{help}</div>} if help
    field
  end

  def check_box_tag_group(name, values, options = {})
    selections = []
    values.each do |item|
      if item.is_a?(Hash)
        value = item[:value]
        text = item[:label]
        help = item.delete(:help)
      else
        value = item
        text = item
      end
      box = check_box_tag(name, value)
      selections << boolean_field_wrapper(box, name, value, text)
    end
    label = options[:label]
    semantic_group("check-box", name, label, selections, options)
  end

end

