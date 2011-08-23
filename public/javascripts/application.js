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
    west__resizable: false,
    east__slidable: false,
    east__closable: true,
    east__resizable: false,
    east__minSize: 237
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
    form   = $('form');
    url    = form.attr('action');
    fdata  = form.serializeArray();

    //Gera inputs para cadastrar a ordem da lista
    //if (form.attr('id') == 'order') {
    //  var order = 1;
        //  $('#sortable li').each(function(){
        //    var id = $(this).attr('id');
        //    $('#sortable').after('<input type="hidden" name="organizer['+id+']" value="'+order+'">');
        //    order++;
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

  //binda o enter dentro do form para enviar o form com ajax
  $('form input').live('keydown',function(e){
    if (e.which == '13') {
      $('input[type=submit], .button.save').click();
    }
  });

  //Seleciona e desseleciona o item do dataTable no clique simples
  $('table.list tbody tr').live('click', function(){
    t = $(this);
    ctrl = $('#controller').val();
    id = $(':first-child',t).html()

    klass = 'ui-state-default';

    $('table.list tbody tr.'+klass).removeClass(klass);
    t.addClass(klass);

    url = '/' + ctrl + '/';
    $('.button.show'    ).attr('href', url + id              );
    $('.button.edit'    ).attr('href', url + id + '/edit'    );
    $('.button.delete'  ).attr('href', url + id              );
    $('.button.editpass').attr('href', url + 'editpass/' + id);
  });

  //Abre pra item para edição no duplo clique
  $('table.list tbody tr').live('dblclick', function(){$('.button.show').click();});

  //todos os links em 'west' e 'center' ou em 'north' com o parâmetro ajax="true" com requisição ajax
  $('#menu a[href*=/], .ui-layout-center a[href*=/], .ui-layout-north a[href*=/][ajax=true]').live('click', function(){
    t = $(this);
    url = t.attr('href');
    data = '';
    type = 'GET';
    dataType = 'html'

    rgx_json = /json$/gi
    is_json = rgx_json.test(url);

    if (t.hasClass('delete')){
      data = '_method=delete';
      type = 'POST';
      if (!confirm('Tem certeza?')){return false;}
    }

    if (t.attr('ajax') != "false") {

      $.ajax({
        url: url,
        data: data,
        type: type,
        dataType: dataType,
        success: function(data){
          if (is_json) {
            eval(data);
          } else {
            $('.ui-layout-center').empty().append(data);
          }
        }
      });

      return false;
    }

  }); //fecha todos os links em 'west' e 'center' ou em 'north' com o parâmetro ajax="true" com requisição ajax

  $('.button.upload').live('click', function(){
    t = $(this);
    showDialog(t.attr('href'));
    return false;
  });

  //Executar antes de todas as requisições ajax
  $('body').ajaxStart(function(){
    //Some com a explicação de erros
    $('#errorExplanation').slideUp('fast');

    $('#waiting').fadeTo('normal', 0.9);

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
    $('#waiting').fadeOut('normal');

    //prevent ajaxSuccess twice or more
    if ($('#ajaxSuccess').attr('value') == 'true') {
      return false;
    } else {
      $('#waiting').after('<input type="hidden" id="ajaxSuccess" value="true"/>');
    }

    //Lista organizável
    //$('#sortable').sortable({ axis: 'y', placeholder: 'ui-state-highlight' }).disableSelection();

    $('table.list').dataTable({
        "bJQueryUI": true
      , "sPaginationType": "full_numbers"
      , "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Tudo"]]
      , "oLanguage": { "sUrl": "/javascripts/dataTable/pt_BR.txt" }
      , "bRetrieve": true
    });

    $('.buttonset').buttonset();

    //masking some inputs
    $('.mask-phone').mask("(99) 9999-9999? r.9999",{placeholder:" "});
    $('.mask-cnpj' ).mask("99.999.999/9999-99"    ,{placeholder:" "});
    $('.mask-cep'  ).mask("99999-999"             ,{placeholder:" "});

    //toggleables em show
    $('.toggleable').each(function(){
      toggle = $(this);
      title = toggle.hide().prev();

      title.css('cursor', 'pointer');
      title.prepend('<span class="ui-icon ui-icon-triangle-1-e" style="display:inline-block"></span>');

      title.click(function(){
        t = $(this);
        t.next().slideToggle();
        ind = $('span', t);
        ind.toggleClass('ui-icon-triangle-1-e');
        ind.toggleClass('ui-icon-triangle-1-s');
      });
    });

    message();
    limit_div_content();
    make_buttons();
  }); // fecha ajaxSuccess

  $('body').ajaxError(function(){
    alert('Erro');

    //fadeOut na div de processamento
    $('#waiting').fadeOut('normal');
  });

  $('#calendario').datepicker();

  message();
  limit_div_content();

  //logout_on_timeout
  set_timeout();
  $(document).bind('mousemove click keypress scroll', reset_timer);

}); //close document.read

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

    $('.notice').remove();
  }
}

function limit_div_content() {
  center  = $('.ui-layout-center').outerHeight();
  mnu     = $('#menu_wrapper').outerHeight();
  content = $('#content_wrapper');

  ctt_padding_top    = content.css('padding-top').match(new RegExp('[0-9]+', ""))*1;
  ctt_padding_bottom = content.css('padding-bottom').match(new RegExp('[0-9]+', ""))*1;
  ctt_padding = ctt_padding_bottom + ctt_padding_top;

  content.css('height', (center - mnu - ctt_padding - 10) + 'px');
}

function make_buttons() {
  $('.button').each(function(){
    t = $(this);
    params = {icons: {primary: ''}, text: true};

    icn = t.attr('icon'); //icone
    if (icn != undefined && icn != '') params['icons']['primary'] = 'ui-icon-' + icn;

    txt = t.attr('caption'); //text boolean
    if (txt != undefined && txt != '' && txt == 'false') params['text'] = false;

    t.button(params);
  });
}

// Passar valor como 123456.78 (ponto como separador de decimais)
// Será retornado um valor 123.46,78
function toCurrency(nStr){
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? ',' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + '.' + '$2');
    }
    return x1 + x2;
}

var timer;

function reset_timer() {
  window.clearInterval(timer);
  set_timeout();
}

function set_timeout() {
  timer=setInterval("logout()",5*60000); // 5 min
}

function logout(){
  $.get('/user_session/timeout.json', function(force_logout){
    if (force_logout) {
      window.location = "/logout";
    }
  });
}

function showDialog(url){
  rdm = Math.floor(Math.random()*1001);
  ctr = 'ctr'+rdm;
  ifm = 'ifm'+rdm;
  dlH = 280; //Dialog Height

  $('.ui-layout-center').append('<div id="'+ctr+'" title="Upload de arquivo" />');
  contnr = $("#"+ctr);
  contnr.html('<iframe id="'+ifm+'" name="'+ifm+'" width="100%" height="100%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />');
  contnr.dialog({
    modal: true,
    show: 'fade',
    height: 215,
    width: 550,
    hide: 'fade',
    buttons: [{
      text: "Enviar",
      click: function() {
        $('form', frames[ifm].document).submit();
        if (contnr.dialog( "option", "height") != dlH ) {
          contnr.dialog( "option", "height", dlH );
        }
        //setTimeout("contnr.dialog('close');", 5000);
      }
    }],
    close: function(event, ui) {
      contnr.dialog('destroy');
      $('#'+ifm).remove()
    }
  });
  $("#"+ifm).attr("src", url);
  return false;
}

function removeParentTR(obj) {
  //acha TR pai do objeto passado como parâmetro
  while (!obj.is('tr')) {
    obj = obj.parent();
  }
  obj.remove(); //remove TR pai
}

