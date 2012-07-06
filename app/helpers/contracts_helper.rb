module ContractsHelper

  def print_contract list, type_id
    s = "<ol class=\"#{Contract::ListTypes.find(type_id).name}\">"
    list.each do |item|
      text = item.text
      while text =~ /<<(.+?)>>/ do
        text.sub! "<<#{$1}>>", eval(Contract::KEYWORDS[$1.to_sym][:command] || "''")
      end
      s += "<li>#{text}#{print_contract item.childs, item.list_type_id}</li>"
      s += "<p>___________________________</p>" if item.rubric
    end
    s += "</ol>"
  end


  def list_dynamic_data
    s  = '<table class="zebra" cellpadding="3" cellspacing="0" border="0">'
    (Contract::KEYWORDS.sort {|x,y| x[0].to_s <=> y[0].to_s}).each do |key|
      s += '<tr>'
      s += "<td>&lt;&lt;#{key[0]}&gt;&gt;</td><td><span class=\"comment\"> #{key[1][:description]}</span></td>"
      s += '</tr>'
    end
    s += '</table>'
  end

end
