module PermissionsHelper



#<div class="w25 radiocheck">
#	<span class="wrapper">
#  <span class="title">NCM's</span>
#    <div class="buttonset">
#      <input id="permission_ncms_l" name="permission[ncms]" type="radio" value="l" /><label for="permission_ncms_l">Ler</label>
#      <input checked="checked" id="permission_ncms_e" name="permission[ncms]" type="radio" value="e" /><label for="permission_ncms_e">Escrever</label>
#      <input id="permission_ncms_s" name="permission[ncms]" type="radio" value="s" /><label for="permission_ncms_s">Sem acesso</label>
#    </div>
#	</span>
#</div>

  #Actions New and Edit
  def perm_options(controller, nick, user)
    perm = [{"e" => "Escrever"}, {"l" => "Ler"}, {"s" => "Sem acesso"}]

    radios = ""

    perm.each { |n| radios += perm_radio(controller, n.keys[0].to_s, user) + "<label for=\"permission_#{controller.to_s}_#{n.keys[0].to_s}\">#{n.values[0]}</label>" }

    s  = "<span class=\"perm_label\">#{nick}</span> #{radios}"


    <<-HTML
    <div class="w25 radiocheck">
    	<span class="wrapper">
      <span class="title">#{nick}</span>
        <div class="buttonset">
          #{radios}
        </div>
    	</span>
    </div>
    HTML


  end

  def perm_radio(controller, val, user)
    chk = user.has_role? controller.to_s + "_" + val
    s = radio_button("permission", controller, val, {:checked => chk})
  end


  #Action Show
  def perm_table_line(user)
    s = ""

    Role.order_by_values.each do |p|
    # perm.each do |p|
      # a = p[:name].split "_" #array
      # l = a.pop              #level of access
      # c = a.join('_')        #controller

      s += "<tr>"
      s += "<td>#{p.values[0]}</td>" #Imprime nome amigável do controller

      ['e', 'l', 's'].each do |level|
        s += user.has_role?(p.keys[0].to_s + '_' + level) ? "<td><span class=\"ui-icon ui-icon-check\"></span></td>" : "<td></td>" #Imprime o acesso
      end
      s += "</tr>"
    end
    s
  end

  def perm_table(user)
    s = <<-TABLE
        <table id="permissions">
          <thead class="ui-widget-header">
            <tr>
              <th>Área</th>
              <th>Escrita</th>
              <th>Leitura</th>
              <th>Sem acesso</th>
            </tr>
          </thead>
          <tbody>#{perm_table_line(user)}</tbody>
        </table>
        TABLE
    s
  end

end

