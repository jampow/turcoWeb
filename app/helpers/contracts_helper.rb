module ContractsHelper

  def print_contract list
    s = "<ol>"
    list.each do |item|
      text = item.text
      while text =~ /<<(.+?)>>/ do
        text.sub! "<<#{$1}>>", eval(Contract::KEYWORDS[$1.to_sym] || "''")
      end
      s += "<li>#{text}#{print_contract item.childs}</li>"
    end
    s += "</ol>"
  end

end
