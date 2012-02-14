module AccountPlansHelper
  
  def apportionments_toolbar f , btns = ['add', 'save', 'del']
    flash[:create_apportionments_table] = true
    s  = "<div class=\"form-toolbar\">"
    s += btn_apportionments_add  if btns.include? 'add'
    s += btn_apportionments_del  if btns.include? 'del'
    s += btn_apportionments_save if btns.include? 'save'
    s += "</div>"
  end
  
  def btn_apportionments_add
    flash[:btn_apportionments_add] = true
    html = link_to "Adicionar", "#", :class   => "button new-apportionment", 
                                     :caption => "false",
                                     :icon    => "plus"
  end
  
  def btn_apportionments_del
    flash[:btn_apportionments_del] = true
    html = link_to "Remover", "#", :class   => "button del-apportionment", 
                                   :caption => "false",
                                   :icon    => "minus"
  end
  
  def btn_apportionments_save
    flash[:btn_apportionments_save] = true
    html = link_to "Salvar", "#", :class   => "button save-apportionment", 
                                  :caption => "false",
                                  :icon    => "check"
  end
  



  def js_apportionments_create_table
    editing? ? html = "$('#apportionments tbody tr:last').remove();" : html = ''
    html += <<-JS
              var oTable = $('#apportionments').dataTable(dTableConfig);
              //Array com o index das colunas q deve ser ocultadas
              //var invCols = [0,1];

              $('#apportionments').undelegate('tr', 'click');
              $('#apportionments').delegate(  'tr', 'click', function(){
                var t = $(this);
                $('tr.ui-state-default').removeClass('ui-state-default');
                t.addClass('ui-state-default');
                $('input', t).each(function(){
                  var th = $(this);
                  var id = th.attr('id');
                  var newId = id.replace(/_([0-9])+_/, '_0_');
                  $('#'+newId).val( th.val() );
                });
              });
            JS

    if editing?
      html += <<-JS
              $('#apportionments tbody td input').each(function(){
                var t   = $(this);
                var val = t.val();
                t.next().append(val);
              });
              JS
    end

    flash[:create_apportionments_table] = false
    html
  end

  def js_apportionments_add
    html  = <<-JS
              $('a.new-apportionment').click(function(){
                $('.form-toolbar ~ label input').val('');
                $('tr.ui-state-default').removeClass('ui-state-default');
                return false;
              });
            JS
    flash[:btn_apportionments_new] = false
    html
  end

  def js_apportionments_del
    html =  <<-JS
              $('a.del-apportionment').click(function(){
                $('tr.ui-state-default input').appendTo('#trash');
                $('input[id$=_name]', '#trash').val('');
                var rowIdx = $('tr.ui-state-default').index('#apportionments tbody tr');
                oTable.fnDeleteRow( rowIdx );
              });
            JS
    flash[:btn_apportionments_del] = false
    html
  end

  def js_apportionments_save
    html  = <<-JS
              $('a.save-apportionment').click(function(){
                var row            = [];
                var values         = [];
                var nextRow        = new Date().getTime();
                var scope          = findParent($(this),'fieldset');
                var inpts          = $('label input', scope);
                var empty          = false;
                var validateFields = ['rate'];
                inpts.each(function(){
                  var t = $(this);
                  var name  = t.attr('name').replace('0', nextRow);
                  var id    = t.attr('id'  ).replace('0', nextRow);
                  var value = t.val();
                  var field = id.replace(/.+([0-9])+_/, '');

                  if (validateFields.indexOf(field) != -1 && value == '') empty = true;

                  values.push(value);
                  row.push('<input type="hidden" id="'+id+'" name="'+name+'" value="'+value+'" /><span>'+value+'</span>');
                });

                if (empty == true) {
                  alert("Há campo(s) vazio(s), não pode inserir");
                  return false;
                }

                if ($('tr.ui-state-default').length == 0) {
                  oTable.fnAddData(row);
                  //$('#sales_order_items tbody tr').each(function(){
                  //  for (i = 0; i < invCols.length; i++) {
                  //    $('td:eq('+invCols[i]+')', $(this)).addClass('hide');
                  //  }
                  //});
                } else {
                  $('tr.ui-state-default td').each(function(){
                    var t     = $(this);
                    var idx   = $('tr.ui-state-default td').index(t);
                    var to    = $('input', t).attr('id');
                    var from  = to.replace(/_([0-9])+_/, '_0_');
                    var value = values[idx];
                    $('#'+to).val(value);
                    $('span', t).text(value);
                  });
                }
                inpts.val('');
                $('tr.ui-state-default').removeClass('ui-state-default');
                return false;
              });
            JS
    flash[:btn_apportionments_save] = false
    html
  end

  
end
