module PermissionsHelper

  #Actions New and Edit
  def perm_options(controller, nick, user)
    perm = {"e" => "Escrever", "l" => "Ler", "s" => "Sem acesso"}

    radios = ""

    perm.each { |n, full| radios += perm_radio(controller, n, user) + "<label for=\"permission_#{controller.to_s}_#{n}\">#{full}</label>" }

    s  = "<span class=\"perm_label\">#{nick}</span> #{radios}"
  end

  def perm_radio(controller, val, user)
    chk = user.has_role? controller.to_s + "_" + val
    s = radio_button("permission", controller, val, {:checked => chk})
  end


  #Action Show
  def perm_table_line(perm)
    s = ""

    perm.each do |p|
      a = p[:name].split "_" #array
      c = a[0]               #controller
      l = a[1]               #level of access


      s += "<tr>"
      s += "<td>#{Role.roles[c.to_sym]}</td>" #Imprime nome amigável do controller

      ['e', 'l', 's'].each do |level|
        s += level == l ? "<td><span class=\"ui-icon ui-icon-check\"></span></td>" : "<td></td>" #Imprime o acesso
      end
      s += "</tr>"
    end
    s
  end

  def perm_table(perm)
    s = <<-TABLE
        <table id="permissions">
          <thead class="ui-widget-header">
            <tr>
              <td>Área</td>
              <td>Escrita</td>
              <td>Leitura</td>
              <td>Sem acesso</td>
            </tr>
          </thead>
          <tbody>#{perm_table_line(perm)}</tbody>
        </table>
        TABLE
    s
  end

end
