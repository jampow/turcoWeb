module ContractsHelper

  def print_contract list, type_id
    s = "<ol class=\"#{Contract::ListTypes.find(type_id).name}\">"
    list.each do |item|
      text = item.text
      while text =~ /<<(.+?)>>/ do
        text.sub! "<<#{$1}>>", eval(Contract::KEYWORDS[$1.to_sym] || "''")
      end
      s += "<li>#{text}#{print_contract item.childs, item.list_type_id}</li>"
    end
    s += "</ol>"
  end

end
