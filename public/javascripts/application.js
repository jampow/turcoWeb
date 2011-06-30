$(function(){

  //constroi layout
  $('body').layout({
    //applyDefaultStyles: true,
    north__size: 60,
    north__slidable: false,
    north__closable: false,
    north__resizable: false,
    west__slidable: false,
    west__closable: false,
    west__resizable: false
  });


  //constroi menu
  $('#menu').accordion({fillSpace: true});

  make_buttons();

  //formulários com requisição ajax
  $('input[type=submit], .button.save').live('click', function(){

    //atualiza todos as textareas q usam ckeditor
    //for ( instance in CKEDITOR.instances ){
    //  CKEDITOR.instances[instance].updateElement();
    //}

    //form = $(this).parents('form');
    form = $('form');
    url = form.attr('action');
    fdata = form.serializeArray();

    //Gera inputs para cadastrar a ordem da lista
    //if (form.attr('id') == 'order') {
    //  var order = 1;
		//  $('#sortable li').each(function(){
		//	  var id = $(this).attr('id');
		//	  $('#sortable').after('<input type="hidden" name="organizer['+id+']" value="'+order+'">');
		//	  order++;
		//  });
    //}

    $.ajax({
      url: url,
      data: fdata,
      type: 'POST',
      dataType: 'html',
      success: function(data){
        $('.ui-layout-center').empty().append(data);
      }
    });

    return false;
  }); //fecha formulários com requisição ajax

  //Seleciona e desseleciona o item do dataTable no clique simples
  $('table.list tbody tr').live('click', function(){
    t = $(this);
    controller = $('#controller').val();
    id = $(':first-child',t).html()

    klass = 'ui-state-default';

    $('table.list tbody tr.'+klass).removeClass(klass);
    t.addClass(klass);

    url = '/' + controller + '/';
    $('.button.show'    ).attr('href', url + id              );
    $('.button.edit'    ).attr('href', url + id + '/edit'    );
    $('.button.delete'  ).attr('href', url + id              );
    $('.button.editpass').attr('href', url + 'editpass/' + id);
  });

  //Abre pra item para edição no duplo clique
  $('table.list tbody tr').live('dblclick', function(){$('.button.show').click();});

  //todos os links em 'west' e 'center' ou em 'north' com o parâmetro ajax="true" com requisição ajax
  $('#menu a[href*=/], .ui-layout-center a[href*=/], .ui-layout-north a[href*=/][ajax=true]').live('click', function(){
    url = $(this).attr('href');
    data = '';

    if ($(this).hasClass('delete')){
      data = '_method=delete';
      type = 'POST';
      if (!confirm('Tem certeza?')){return false;}
    } else {
      type = 'GET'
    }

    $.ajax({
      url: url,
      data: data,
      type: type,
      dataType: 'html',
      success: function(data){
        $('.ui-layout-center').empty().append(data);
      }
    });

    return false;
  }); //fecha todos os links em 'west' e 'center' ou em 'north' com o parâmetro ajax="true" com requisição ajax

  //Executar antes de todas as requisições ajax
  $('body').ajaxStart(function(){
    //Some com a explicação de erros
    $('#errorExplanation').slideUp('fast');

    //$('#waiting').css('display', 'block').fadeTo(0, 0.3);

	  //Antes de enviar intervalos
	  //if ($('form.edit_interval').length != 0 ) {
	  //  //console.log($('form.edit_interval').attr('action'));
    //}

    //destroy all instances of CKEditor
    //for ( instance in CKEDITOR.instances ){
    //  CKEDITOR.instances[instance].destroy();
    //}

  });

  //Executar depois de todas as requisições ajax
  $('body').ajaxSuccess(function(){
    //SlideDown nos erros
    $('#errorExplanation').hide().slideDown('slow');

    //fadeOut na div de processamento
    //$('#waiting').fadeOut('fast');

    //Lista organizável
    //$('#sortable').sortable({ axis: 'y', placeholder: 'ui-state-highlight' }).disableSelection();

    $('table.list').dataTable({
			  "bJQueryUI": true
			, "sPaginationType": "full_numbers"
		  , "oLanguage": {
			    "sLengthMenu": "_MENU_ itens por página"
			  , "sZeroRecords": "Desculpe - Nenhum registro encontrado"
			  , "sInfo": "Registros de _START_ até _END_ de um total de _TOTAL_"
			  , "sInfoEmpty": "Registros de 0 até 0 de um total de 0"
			  , "sInfoFiltered": "(filtrado de um total de _MAX_ registros)"
	      , "sProcessing": "Processando..."
	      , "sInfoPostFix": ""
	      , "sSearch": "Busca"
	      , "sUrl": ""
	      , "oPaginate": {
		        "sFirst":    "Primeira"
		      , "sPrevious": "Anterior"
		      , "sNext":     "Próxima"
		      , "sLast":     "Última"
	        }
		    }
		});

    $('.buttonset').buttonset();

    $('.button'  ).button();
    $('.show'    ).button( "option", "icons", {primary:'ui-icon-search'           });
    $('.edit'    ).button( "option", "icons", {primary:'ui-icon-pencil'           });
    $('.delete'  ).button( "option", "icons", {primary:'ui-icon-trash'            });
    $('.new'     ).button( "option", "icons", {primary:'ui-icon-document'         });
    $('.order'   ).button( "option", "icons", {primary:'ui-icon-transferthick-e-w'});
    $('.editpass').button( "option", "icons", {primary:'ui-icon-key'              });
    $('.back'    ).button( "option", "icons", {primary:'ui-icon-triangle-1-w'     });
    $('.save'    ).button( "option", "icons", {primary:'ui-icon-disk'             });
    message();
    limit_div_content();
    make_buttons();
  }); // fecha ajaxSuccess
  message();
  limit_div_content
});

$(window).bind('resize', limit_div_content);

function message() {
  msg = $('.notice').text();

  if ( msg != "" ) {
    $.jGrowl(msg,{
      //theme: 'smoke',
      life: 5000,
      position: 'center',
      header: '<b>MENSAGEM</b>'
    });
  }
}

function limit_div_content() {
  center  = $('.ui-layout-center').outerHeight();
  menu    = $('#menu_wrapper').outerHeight();
  content = $('#content_wrapper');

  ctt_padding_top    = content.css('padding-top').match(new RegExp('[0-9]+', ""))*1;
  ctt_padding_bottom = content.css('padding-bottom').match(new RegExp('[0-9]+', ""))*1;
  ctt_padding = ctt_padding_bottom + ctt_padding_top;

  content.css('height', (center - menu - ctt_padding) + 'px')
}

function make_buttons() {
  $('.button').each(function(){
    t = $(this);
    i = t.attr('icon') //icone
    i == undefined ? t.button() : t.button({icons:{primary: 'ui-icon-' + i} })
  });
}

