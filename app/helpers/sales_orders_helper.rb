module SalesOrdersHelper

  def new_item_toolbar f , btns = ['add', 'save']
    flash[:create_table_item] = true
    s  = "<div class=\"form-toolbar\">"
    s += btn_new_item  if btns.include? 'add'
    s += btn_save_item if btns.include? 'save'
    #s += hidden_field "new_item", new_fields(f, :sales_order_items)
    s += "</div>"
  end

  def btn_new_item
    flash[:btn_new_item] = true
    html = "<a href=\"#\" class=\"button new-item\" caption=\"false\" icon=\"plus\" >Novo Item</a>"
  end

  def btn_save_item
    flash[:btn_save_item] = true
    html = "<a href=\"#\" class=\"button save-item\" caption=\"false\" icon=\"check\" >Salvar Item</a>"
  end

  def js_create_table_item
    html  = <<-JS
              var oTable = $('#sales_order_items').dataTable({
                               "bJQueryUI": true
                             , "sPaginationType": "full_numbers"
                             , "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Tudo"]]
                             , "oLanguage": { "sUrl": "/javascripts/dataTable/pt_BR.txt" }
                             , "bRetrieve": true
                           });
              var invCols = ['0']; //Array com o index das colunas q deve ser ocultadas
            JS
    flash[:create_table_item] = false
    html
  end

  def js_new_item
    html  = <<-JS
              $('a.new-item').click(function(){
                $('.form-toolbar ~ label input').val('');
                return false;
              });
            JS
    flash[:btn_new_item] = false
    html
  end

  def js_save_item
    html  = <<-JS
              $('a.save-item').click(function(){
                var row  = [];
                var nextRow = oTable.fnGetNodes().length + 1;
                var scope = findParent($(this),'fieldset');
                var inpts = $('label input', scope);
                inpts.each(function(){
                  var t = $(this);
                  var name  = t.attr('name').replace('0', nextRow);
                  var id    = t.attr('id'  ).replace('0', nextRow);
                  var value = t.val();
                  t.val('');
                  row.push('<input type="hidden" id="'+id+'" name="'+name+'" value="'+value+'" />'+value);
                });
                var item = oTable.fnAddData(row)[0]+1;
                var trow = $('tr:eq('+item+')', oTable);
                for (i = 0; i < invCols.length; i++) {
                  $('td:eq('+invCols[i]+')', trow).addClass('hide');
                }
                return false;
              });
            JS
    flash[:btn_save_item] = false
    html
  end

end

