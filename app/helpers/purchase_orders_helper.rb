module PurchaseOrdersHelper

  def btn_purchase_reverse(id)
    link_to "Estornar", "/purchase_orders/reverse/#{id}", :class => "button confirm", :icon => "arrowreturn-1-w"
  end

  def btn_purchase_close(id)
    link_to "Receber pedido", "/purchase_orders/close/#{id}", :class => "button confirm", :icon => "script"
  end

  def new_purchase_item_toolbar f , btns = ['add', 'save', 'del']
    flash[:create_purchase_table_item] = true
    s  = "<div class=\"form-toolbar\">"
    s += btn_purchase_new_item  if btns.include? 'add'
    s += btn_purchase_del_item  if btns.include? 'del'
    s += btn_purchase_save_item if btns.include? 'save'
    #s += hidden_field "new_item", new_fields(f, :purchase_order_items)
    s += "</div>"
  end

  def btn_purchase_new_item
    flash[:btn_purchase_new_item] = true
    html = "<a href=\"#\" class=\"button new-item\" caption=\"false\" icon=\"plus\" >Adicionar Item</a>"
  end

  def btn_purchase_del_item
    flash[:btn_purchase_del_item] = true
    html = "<a href=\"#\" class=\"button del-item\" caption=\"false\" icon=\"minus\" >Remover Item</a>"
  end

  def btn_purchase_save_item
    flash[:btn_purchase_save_item] = true
    html = "<a href=\"#\" class=\"button save-item\" caption=\"false\" icon=\"check\" >Salvar Item</a>"
  end

  def js_purchase_create_table_item
    #editing? ? html = "$('#purchase_order_items tbody tr:last').remove();" : html = ''
    html = ''
    html += <<-JS
              var oTable = $('#purchase_order_items').dataTable(dTableConfig);
              //Array com o index das colunas q deve ser ocultadas
              //var invCols = [0,1];

              $('#purchase_order_items').undelegate('tr', 'click');
              $('#purchase_order_items').delegate(  'tr', 'click', function(){
                var t = $(this);
                $('tr.ui-state-default').removeClass('ui-state-default');
                t.addClass('ui-state-default');
                $('input', t).each(function(){
                  var th = $(this);
                  var id = th.attr('id');
                  var newId = id.replace(/_([0-9])+_/, '_0_');
                  $('#'+newId).val( th.val() );
                });
                $('#purchase_order_order_items_attributes_0_product_id').trigger('change');
              });
              $('#purchase_order_items tbody td input').each(function(){
                var t = $(this);
                var inputId = t.attr('id').replace(/_([0-9])+_/, '_0_');
                if ($('#'+inputId).hasClass('mask-decimal')){
                  var val = format.number.toDecimal(t.val(), t.attr('decimal'));
                } else {
                  var val = t.val();
                }
                t.next().append(val);
              });
            JS

    flash[:create_purchase_table_item] = false
    html
  end

  def js_purchase_new_item
    html  = <<-JS
              $('a.new-item').click(function(){
                $('.form-toolbar ~ label input').val('');
                $('tr.ui-state-default').removeClass('ui-state-default');
                return false;
              });
            JS
    flash[:btn_purchase_new_item] = false
    html
  end

  def js_purchase_del_item
    html =  <<-JS
              $('a.del-item').click(function(){
                $('tr.ui-state-default input').appendTo('#trash');
                $('input[id$=_name]', '#trash').val('');
                var rowIdx = $('tr.ui-state-default').index('#purchase_order_items tbody tr');
                oTable.fnDeleteRow( rowIdx );

                //Limpa form
                $('.form-toolbar ~ label input').val('');
                $('tr.ui-state-default').removeClass('ui-state-default');
              });
            JS
    flash[:btn_purchase_del_item] = false
    html
  end

  def js_purchase_save_item
    html  = <<-JS
              $('a.save-item').click(function(){
                var row            = [];
                var values         = [];
                var labels         = [];
                var nextRow        = new Date().getTime();
                var scope          = findParent($(this),'fieldset');
                var inpts          = $('label input, label select', scope);
                var empty          = false;
                var validateFields = ['name', 'quantity', 'unit_value'];
                var hiddenColumns  = getHiddenIndex($('#purchase_order_items thead th:hidden'));
                inpts.each(function(){
                  var t = $(this);
                  var name  = t.attr('name').replace('0', nextRow);
                  var id    = t.attr('id'  ).replace('0', nextRow);
                  var value = t.val();
                  var label = value;
                  var field = id.replace(/.+([0-9])+_/, '');
                  var decim = t.attr('decimal') || '';
                  var klass = '';

                  if (validateFields.indexOf(field) != -1 && value == '') empty = true;
                  if (decim !== '') {
                    decim = 'decimal="'+t.attr('decimal')+'"';
                    klass += ' mask-decimal';
                  }

                  values.push(value);
                  labels.push(label);
                  row.push('<input type="hidden" id="'+id+'" name="'+name+'" value="'+value+'" '+decim+' class="'+klass+'" /><span>'+value+'</span>');
                });

                if (empty == true) {
                  alert("Há campo(s) vazio(s)", "Não pode inserir");
                  return false;
                }

                if ($('tr.ui-state-default').length == 0) {
                  oTable.fnAddData(row);
                  $.each(hiddenColumns, function(idx, val){
                    $('#purchase_order_items tbody tr:last td:eq('+val+')').addClass('hide');
                  });
                } else {
                  $('tr.ui-state-default td').each(function(){
                    var t     = $(this);
                    var idx   = $('tr.ui-state-default td').index(t);
                    var to    = $('input', t).attr('id');
                    var label = labels[idx];
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
    flash[:btn_purchase_save_item] = false
    html
  end

end

