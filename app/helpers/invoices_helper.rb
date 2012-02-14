module InvoicesHelper
  
  def invoice_item_toolbar f , btns = ['add', 'save', 'del']
    flash[:create_invoice_table_item] = true
    s  = "<div class=\"form-toolbar\">"
    s += btn_invoice_new_item  if btns.include? 'add'
    s += btn_invoice_del_item  if btns.include? 'del'
    s += btn_invoice_save_item if btns.include? 'save'
    s += "</div>"
  end

  def btn_invoice_new_item
    flash[:btn_invoice_new_item] = true
    html = "<a href=\"#\" class=\"button new-item\" caption=\"false\" icon=\"plus\" >Adicionar Item</a>"
  end

  def btn_invoice_del_item
    flash[:btn_invoice_del_item] = true
    html = "<a href=\"#\" class=\"button del-item\" caption=\"false\" icon=\"minus\" >Remover Item</a>"
  end

  def btn_invoice_save_item
    flash[:btn_invoice_save_item] = true
    html = "<a href=\"#\" class=\"button save-item\" caption=\"false\" icon=\"check\" >Salvar Item</a>"
  end

  def js_invoice_create_table_item
    html = ''
    html += <<-JS
              var oTable = $('#invoice_items').dataTable(dTableConfig);

              $('#invoice_items').undelegate('tr', 'click');
              $('#invoice_items').delegate(  'tr', 'click', function(){
                var t = $(this);
                $('tr.ui-state-default').removeClass('ui-state-default');
                t.addClass('ui-state-default');
                $('input', t).each(function(){
                  var th = $(this);
                  var id = th.attr('id');
                  var newId = id.replace(/_([0-9])+_/, '_0_');
                  $('#'+newId).val( th.val() );
                });
                $('#invoice_items_attributes_0_product_id').trigger('change');
              });
            JS

    if editing?
      html += <<-JS
              $('#invoice_items tbody td input').each(function(){
                var t   = $(this);
                var val = t.val();
                t.next().append(val);
              });
              JS
    end

    flash[:create_sales_table_item] = false
    html
  end

  def js_invoice_new_item
    html  = <<-JS
              $('a.new-item').click(function(){
                $('.form-toolbar ~ label input').val('');
                $('tr.ui-state-default').removeClass('ui-state-default');
                return false;
              });
            JS
    flash[:btn_sales_new_item] = false
    html
  end

  def js_invoice_del_item
    html =  <<-JS
              $('a.del-item').click(function(){
                $('tr.ui-state-default input').appendTo('#trash');
                $('input[id$=_name]', '#trash').val('');
                var rowIdx = $('tr.ui-state-default').index('#sales_order_items tbody tr');
                oTable.fnDeleteRow( rowIdx );
              });
            JS
    flash[:btn_sales_del_item] = false
    html
  end

  def js_invoice_save_item
    html  = <<-JS
              $('a.save-item').click(function(){
                var row            = [];
                var values         = [];
                var nextRow        = new Date().getTime();
                var scope          = findParent($(this),'fieldset');
                var inpts          = $('label input, label select', scope);
                var empty          = false;
                var validateFields = ['name', 'quantity', 'unit_value'];
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
                  alert("Há campos vazios, não pode inserir");
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
    flash[:btn_sales_save_item] = false
    html
  end
  
end
