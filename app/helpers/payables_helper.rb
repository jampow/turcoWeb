module PayablesHelper
  def new_payable_division_item_toolbar f , btns = ['add', 'save', 'del']
    flash[:create_payable_division_table_item] = true
    s  = "<div class=\"form-toolbar\">"
    s += btn_payable_division_new_item  if btns.include? 'add'
    s += btn_payable_division_del_item  if btns.include? 'del'
    s += btn_payable_division_save_item if btns.include? 'save'
    #s += hidden_field "new_item", new_fields(f, :payable_division_order_items)
    s += "</div>"
  end

  def btn_payable_division_new_item
    flash[:btn_payable_division_new_item] = true
    html = "<a href=\"#\" class=\"button new-item\" caption=\"false\" icon=\"plus\" >Adicionar Item</a>"
  end

  def btn_payable_division_del_item
    flash[:btn_payable_division_del_item] = true
    html = "<a href=\"#\" class=\"button del-item\" caption=\"false\" icon=\"minus\" >Remover Item</a>"
  end

  def btn_payable_division_save_item
    flash[:btn_payable_division_save_item] = true
    html = "<a href=\"#\" class=\"button save-item\" caption=\"false\" icon=\"check\" >Salvar Item</a>"
  end

  def js_payable_division_create_table_item
    # editing? ? html = "$('#payable_division_order_items tbody tr:last').remove();" : html = ''
    html = <<-JS
              var oTable = $('#payable_division_order_items').dataTable(dTableConfig);
              //Array com o index das colunas q deve ser ocultadas
              //var invCols = [0,1];

              $('#payable_division_order_items').undelegate('tr', 'click');
              $('#payable_division_order_items').delegate(  'tr', 'click', function(){
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
              $('#payable_division_order_items tbody td input').each(function(){
                var t   = $(this);
                var val = t.val();
                t.next().append(val);
              });
              JS
    end

    flash[:create_payable_division_table_item] = false
    html
  end

  def js_payable_division_new_item
    html  = <<-JS
              $('a.new-item').click(function(){
                $('.form-toolbar ~ label input').val('');
                $('tr.ui-state-default').removeClass('ui-state-default');
                return false;
              });
            JS
    flash[:btn_payable_division_new_item] = false
    html
  end

  def js_payable_division_del_item
    html =  <<-JS
              $('a.del-item').click(function(){
                $('tr.ui-state-default input').appendTo('#trash');
                $('input[id$=_value]', '#trash').val('');
                var rowIdx = $('tr.ui-state-default').index('#payable_division_order_items tbody tr');
                oTable.fnDeleteRow( rowIdx );
              });
            JS
    flash[:btn_payable_division_del_item] = false
    html
  end

  def js_payable_division_save_item
    html  = <<-JS
              $('a.save-item').click(function(){
                var row            = [];
                var values         = [];
                var nextRow        = new Date().getTime();
                var scope          = findParent($(this),'fieldset');
                var inpts          = $('label input', scope);
                var empty          = false;
                var validateFields = ['value'];
                inpts.each(function(){
                  var t = $(this);
                  var name  = t.attr('name').replace('1', nextRow);
                  var id    = t.attr('id'  ).replace('1', nextRow);
                  var value = t.val();
                  var field = id.replace(/.+([0-9])+_/, '');

                  if (validateFields.indexOf(field) != -1 && value == '') empty = true;

                  values.push(value);
                  row.push('<input type="hidden" id="'+id+'" name="'+name+'" value="'+value+'" /><span>'+value+'</span>');
                });

                if (empty == true) {
                  alert("Há campo(s) vazio(s)", "Não pode inserir");
                  return false;
                }

                if ($('tr.ui-state-default').length == 0) {
                  oTable.fnAddData(row);
                  //$('#payable_division_order_items tbody tr').each(function(){
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
    flash[:btn_payable_division_save_item] = false
    html
  end


end
