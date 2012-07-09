var dTableConfig = {
  "bJQueryUI": true,
  "sPaginationType": "full_numbers",
  "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Tudo"]],
  "oLanguage": {
    "sLengthMenu": "_MENU_ itens por página",
    "sZeroRecords": "Nenhum registro encontrado",
    "sInfo": "Registros de _START_ até _END_ de um total de _TOTAL_",
    "sInfoEmpty": "Registros de 0 até 0 de um total de 0",
    "sInfoFiltered": "(filtrado de um total de _MAX_ registros)",
    "sProcessing": "Processando...",
    "sInfoPostFix": "",
    "sSearch": "Busca",
    "sUrl": "",
    "oPaginate": {
      "sFirst":    "Primeira",
      "sPrevious": "Anterior",
      "sNext":     "Próxima",
      "sLast":     "Última"
    }
  },
  "bRetrieve": true
};

/*

ooooooooo                                                                        oooo
 888    88o   ooooooo     ooooooo       oo oooooo    ooooooooo8  ooooooo    ooooo888
 888    888 888     888 888     888      888    888 888oooooo8   ooooo888 888    888
 888    888 888     888 888        ooo   888        888        888    888 888    888
o888ooo88     88ooo88     88ooo888 888  o888o         88oooo888 88ooo88 8o  88ooo888o

*/

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

  var ua = $.browser;
  if (ua.webkit || ua.mozilla) {
    $('#browsers').hide();
  }

  //constroi menu
  $('#menu').accordion({fillSpace: true});

  make_buttons();

  //formulários com requisição ajax
  $('input[type=submit], .button.save').live('click', function(){

    //atualiza todos as textareas q usam ckeditor
    //for ( instance in CKEDITOR.instances ){
    //  CKEDITOR.instances[instance].updateElement();
    //}

    //remove máscaras de decimais
    $('.mask-decimal').each(function(){
      var t = $(this);
      t.val(format.decimal.toNumber(t.val()));
    });

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
      cache: false,
      dataType: 'html',
      success: function(data){
        $('.ui-layout-center').empty().append(data);
      }
    });

    return false;
  }); //fecha formulários com requisição ajax

  //binda o enter dentro do form para não fazer nada, nem enviar o form
  $('form input').live('keydown',function(e){
    if (e.which == '13') {
      //$('input[type=submit], .button.save').click();
      return false;
    }
  });

  //Seleciona e desseleciona o item do dataTable no clique simples
  $('table.list tbody tr').live('click', function(){
    t = $(this);
    ctrl = $('#controller').val();
    id = $(':first-child',t).html();

    if (!isNaN(id)) {
      klass = 'ui-state-default';

      $('table.list tbody tr.'+klass).removeClass(klass);
      t.addClass(klass);

      url = '/' + ctrl + '/';
      $('.button.show'    ).attr('href', url + id              );
      $('.button.edit'    ).attr('href', url + id + '/edit'    );
      $('.button.delete'  ).attr('href', url + id              );
      $('.button.editpass').attr('href', url + 'editpass/' + id);
      $('.button.show, .button.edit, .button.delete, .button.editpass').button({disabled:false});
    } else {
      $('.button.show, .button.edit, .button.delete, .button.editpass').attr('href', '#').button({disabled:true});
    }
  });

  //Exibe item da tabela no duplo clique
  $('table.list tbody tr').live('dblclick', function(){$('.button.show').click();});

  //todos os links em 'west' e 'center' ou em 'north' com o parâmetro ajax="true" com requisição ajax
  $('#menu a[href*=/], .ui-layout-center a[href*=/], .ui-layout-north a[href*=/][ajax=true]').live('click', function(){
    t = $(this);
    url = t.attr('href');
    data = '';
    type = 'GET';
    dataType = 'html';

    if (url == '#') {return false;}

    rgx_json = /json$/gi;
    is_json = rgx_json.test(url);

    if (t.hasClass('delete') || t.hasClass('confirm')){
      data = '_method=delete';
      type = 'POST';
      if (!confirm('Tem certeza?')){return false;}
    }

    if (t.attr('ajax') != "false") {

      $.ajax({
        url: url,
        data: data,
        type: type,
        cache: false,
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
    //mostra waiting
    $('#waiting').fadeTo('normal', 0.9);

    //destroy all instances of CKEditor
    //for ( instance in CKEDITOR.instances ){
    //  CKEDITOR.instances[instance].destroy();
    //}
  });

/*

     o      o88                           oooooooo8
    888    oooo   ooooooo   oooo   oooo  888        oooo  oooo   ooooooo     ooooooo    ooooooooo8  oooooooo8  oooooooo8
   8  88    888   ooooo888    888o888     888oooooo  888   888 888     888 888     888 888oooooo8  888ooooooo 888ooooooo
  8oooo88   888 888    888    o88 88o            888 888   888 888         888         888                 888        888
o88o  o888o 888  88ooo88 8o o88o   o88o  o88oooo888   888o88 8o  88ooo888    88ooo888    88oooo888 88oooooo88 88oooooo88
           o88

*/

  //Executar depois de todas as requisições ajax
  $('body').ajaxSuccess(function(){
    //fadeOut na div de processamento
    $('#waiting').fadeOut('normal');

    //Adiciona máscaras de decimais
    $('.mask-decimal').each(function(){
      var t = $(this);
      if (t.val().match(',') === null)
        t.val(format.number.toDecimal(t.val(), t.attr('decimal')));
    });

    //prevent ajaxSuccess twice or more
    if ($('#ajaxSuccess').attr('value') == 'true') {
      return false;
    } else {
      $('#waiting').after('<input type="hidden" id="ajaxSuccess" value="true"/>');
    }

    //Lista organizável
    //$('#sortable').sortable({ axis: 'y', placeholder: 'ui-state-highlight' }).disableSelection();

    $('table.list, table.simple-list').dataTable(dTableConfig);

    $('.buttonset').buttonset();

    //masking some inputs
    $('.mask-phone'  ).mask("(99) 9999-9999? r.9999",{placeholder:" "});
    $('.mask-cnpj'   ).mask("99.999.999/9999-99"    ,{placeholder:" "});
    $('.mask-cpf'    ).mask("999.999.999-99?999"    ,{placeholder:" "});
    $('.mask-code'   ).mask("*****"                 ,{placeholder:" "});
    $('.mask-cep'    ).mask("99999-999"             ,{placeholder:" "});
    $('.mask-cfop'   ).mask("9999"                  ,{placeholder:" "});

    $('.mask-decimal').each(function(){
      var t = $(this);
      var d = t.attr("decimal");
      var conf = {prefix: '', centsSeparator: ',', thousandsSeparator: '.'};
      if (d !== undefined){
        d = d.split(',');
        if (d.length == 2) {
          if (!isNaN(d[0])) conf.limit      = d[0]*1;
          if (!isNaN(d[1])) conf.centsLimit = d[1]*1;
        }
      }
      t.priceFormat(conf);
    });

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

    $('.datepicker').datepicker({'dateFormat': 'yy-mm-dd'});
    $('.autocomplete').each(function(){
      var t    = $(this);
      var src  = t.attr('source');
      var cbk  = t.attr('callback');
      var pref = t.attr('pref');
      t.autocomplete({
        source   : "/autocomplete/"+src,
        minLength: 3,
        select   : function(event, ui){
          $.each(ui.item, function(key, val){
            if (key !== 'value' && key !== 'label' && key !== '') {
              var target = $('#'+pref+key);
              if (target.attr('decimal') !== undefined)
                target.val(format.number.toDecimal(val, target.attr('decimal')));
              else
                target.val(val);
            }
          });

          eval(cbk);
        }
      });
    });

    message();
    make_buttons();
    limit_div_content(); //must be the last call in this block
  }); // fecha ajaxSuccess

//  var notifyError = true;

  /*
     o      o88                          ooooooooooo
    888    oooo   ooooooo   oooo   oooo   888    88  oo oooooo  oo oooooo     ooooooo  oo oooooo
   8  88    888   ooooo888    888o888     888ooo8     888    888 888    888 888     888 888    888
  8oooo88   888 888    888    o88 88o     888    oo   888        888        888     888 888
o88o  o888o 888  88ooo88 8o o88o   o88o  o888ooo8888 o888o      o888o         88ooo88  o888o
           o88
  */

  $('body').ajaxError(function(jqXHR, textStatus, errorThrown){

    thisDialog = $('<div />', {'title': 'Erro'}).appendTo('.ui-layout-center');
    thisDialog.append('<p>Ocorreu algo inesperado no sistema.</p>');
    thisDialog.append('<p>Informações sobre este erro foram enviadas ao administrador do sistema.</p>');
    thisDialog.dialog({
      show: 'fade',
      hide: 'fade',
      buttons: [{
        text: "Ok",
        click: function() {
          thisDialog.dialog('close');
        }
      }],
      close: function(event, ui) {
        thisDialog.dialog('destroy');
        thisDialog.remove();
      }
    });

    //fadeOut na div de processamento
    $('#waiting').fadeOut('normal');

    //Adiciona máscaras de decimais
    $('.mask-decimal').each(function(){
      var t = $(this);
      t.val(format.number.toDecimal(t.val(), t.attr('decimal')));
    });
  });

  $('#calendar').datepicker();

  message();
  limit_div_content();

  //logout_on_timeout
  set_timeout();
  $(document).bind('mousemove click keypress scroll', reset_timer);

  $('#chatMessage').bind('keypress', function(event){
    if ( event.which == 13 ) {
      $('.chat-history').append('<p><span class="chat-who">Usuário: </span>'+$(this).val()+'</p>');
      $(this).val('');
      $('.chat-history').attr({scrollTop: $('.chat-history').attr('scrollHeight')});
    }
  });

}); //close document.read

/*
ooooooooooo                                    o8   o88
 888    88 oooo  oooo  oo oooooo    ooooooo  o888oo oooo   ooooooo  oo oooooo    oooooooo8
 888ooo8    888   888   888   888 888     888 888    888 888     888 888   888  888ooooooo
 888        888   888   888   888 888         888    888 888     888 888   888          888
o888o        888o88 8o o888o o888o  88ooo888   888o o888o  88ooo88  o888o o888o 88oooooo88
*/

$(window).bind('resize', limit_div_content);

function message() {
  msg = $('.notice').text();
  $('.notice').remove();

  if ( msg !== "" ) {
    $('#jGrowl').show();
    $.jGrowl(msg,{
      life: 5000,
      position: 'center',
      header: '<b>MENSAGEM</b>',
      close: function(){
        $('#jGrowl').hide();
      }
    });
  }
}

function limit_div_content() {
  center = $('.ui-layout-center').outerHeight();
  mnu    = $('#menu_wrapper').outerHeight();

  $('#content_wrapper').outerHeight(center - mnu);
}

function make_buttons() {
  $('.button').each(function(){
    t = $(this);
    params = {icons: {primary: ''}, text: true};

    icn = t.attr('icon'); //icone
    if (icn !== undefined && icn !== '') params.icons.primary = 'ui-icon-' + icn;

    txt = t.attr('caption'); //text boolean
    if (txt !== undefined && txt !== '' && txt == 'false') params.text = false;

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
  timer=setInterval("logout()",20*60000); // 20 min
}

function logout(){
  $.get('/user_session/timeout.json', function(force_logout){
    if (force_logout) {
      window.location = "/logout";
    }
  });
}

//TODO: Usar função genérica showModal dentro desta showDialog
function showDialog(url){
  rdm = Math.floor(Math.random()*1001);
  ctr = 'ctr'+rdm;
  ifm = 'ifm'+rdm;
  dlH = 280; //Dialog Height

  $('.ui-layout-center').append('<div id="'+ctr+'" title="Upload de arquivo" />');
  contnr = $("#"+ctr);
  contnr.html('<iframe id="'+ifm+'" name="'+ifm+'" src="'+url+'" width="100%" height="100%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />');
  contnr.dialog({
    modal: true,
    show: 'fade',
    height: 215,
    width: 550,
    hide: 'fade',
    buttons: [{
      text: "Enviar",
      click: function() {
        $('#waiting', frames[ifm].document).fadeTo('normal', 0.7);
        $('form'    , frames[ifm].document).submit();
        if (contnr.dialog("option", "height") != dlH ) {
          contnr.dialog("option", "height", dlH );
        }
        //setTimeout("contnr.dialog('close');", 5000);
      }
    }],
    close: function(event, ui) {
      contnr.dialog('destroy');
      $('#'+ctr).remove();
    }
  });
  return false;
}

function showModal(params){
  rdm = Math.floor(Math.random()*1001);
  ctr = 'ctr'+rdm;
  ifm = 'ifm'+rdm;

  var def = {
    height: 280,
    url: '/',
    title: '',
    width: 550,
    close: function(event, ui) {
      contnr.dialog('destroy');
      $('#'+ctr).remove();
    },
    buttons: []
  };

  var pars = $.extend({}, def, params);

  $('.ui-layout-center').append('<div id="'+ctr+'" title="'+pars.title+'" />');
  contnr = $("#"+ctr);
  contnr.html('<iframe id="'+ifm+'" name="'+ifm+'" src="'+pars.url+'" width="100%" height="100%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />');
  contnr.dialog({
    modal: true,
    show: 'fade',
    height: pars.height,
    width: pars.width,
    hide: 'fade',
    buttons: pars.buttons,
    close: pars.close
  });

  return false;
}

function removeParentTR(ref) {
  //acha TR pai do objeto passado como parâmetro
  var obj = findParent(ref, 'tr');
  obj.remove(); //remove TR pai
}

function findParent(ref, parentSelector) {
  var obj = ref.parent();
  while (!obj.is(parentSelector)) {
    obj = obj.parent();
  }
  return obj;
}

var format = {
  decimal: {
    toNumber: function(val) {
      return val.replace(/\./g, '').replace(',', '.')*1;
    }
  },
  number: {
    toDecimal: function(val, dec) {
      if (dec === undefined) {
        val = val+'';
      } else {
        var d = dec.split(',');
        val = (val*1).toFixed(d[1]) + '';
      }
      return val.replace(/[.]/g, ",").replace(/\d(?=(?:\d{3})+(?:\D))/g, "$&.");
    }
  }
};

/* Yeah! Closure! Tks Nathan Whitehead!!
** If you're reading this and wanna know more about closure
** U can learn more here: http://nathansjslessons.appspot.com/
*/

var len = function(field){
  var bef, aft, f;
  f = function(){
    bef = aft;
    aft = $(field).val().replace(/[\/ \.-]/gi, '').length;
    return {"bef": bef, "aft": aft};
  };
  return f;
};

//Sobrescrevendo o alert
function alert(msg, title){
  var t = $('#alert');
  (title === undefined) ? t.attr('title', '') : t.attr('title', title)
  t.html(msg).dialog({
    modal: true,
    buttons: {
      Ok: function() {
        $(this).dialog("destroy");
      }
    }
  });
}