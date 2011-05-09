module PermissionsHelper

  def perm_options(controller, nick, user)
    perm = ["Escrever", "Ler", "Sem acesso"]

    radios = ""
    perm.each { |n| radios += perm_radio(controller, n[0].chr.downcase, user) + label("permission", controller.to_s + "_" + val) }

    s  = nick + radios
  end

  def perm_radio(controller, val, user)
    chk = user.has_role? controller.to_s + "_" + val
    s = radio_button("permission", controller, val, {:checked => chk})
  end

  def perm_table_line(perm)
    s = ""

    perm.each do |p|
      a = p[:name].split "_" #array
      c = a[0]               #controller
      l = a[1]               #level of access


      s += "<tr>"
      s += "<td>#{Role.roles[c.to_sym]}</td>" #Imprime nome amigável do controller

      ['e', 'l', 's'].each do |level|
        s += level == l ? "<td>X</td>" : "<td></td>" #Imprime o acesso
      end
      s += "</tr>"
    end
    s
  end

  def perm_table(perm)
    s = <<TABLE
        <table>
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

