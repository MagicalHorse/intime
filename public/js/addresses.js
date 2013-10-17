// var areaMap;
$(document).ready(new function() {
  /*
  $.get('/front/addresses/supportshipments.json', function(result) {
    areaMap = result.datas;
  });
  */

  $('#add_address').click(function() {
    // $('#add01 form input[type=text]').each(function(i,e) { $(e).val(''); });
    // $('#add01 form select').each(function(i,e) { $(e).val(''); });
    // $('#add01 div.messages .close').click();
  });

  // 新建地址
  $('#add01 form').bind('ajax:success', function(evt, data, status, xhr){
    if (data.isSuccessful) {
      $('#add01 div.messages').html('<div class="alert alert-success"><a class="close" data-dismiss="alert" href="#">x</a>' + data.message + '</div>');
      document.location.reload();
    }
    else {
      $('#add01 div.messages').html('<div class="alert alert-error"><a class="close" data-dismiss="alert" href="#">x</a>' + data.message + '</div>');
    }
  })

  // 删除地址
  $('a.delete_address').bind('ajax:success', function(evt, data, status, xhr){
    var target = $(evt.currentTarget);
    if (data.isSuccessful) {
      target.parents('div.modal').modal('hide');
      target.parents('form').remove();
      $('#messages').html('<div class="alert alert-success"><a class="close" data-dismiss="alert" href="#">x</a>' + data.message + '</div>');
      $('#left_addresses_size').html(parseInt($('#left_addresses_size').html()) + 1);
    }
    else {
      target.parents('div.modal').modal('hide');
      $('#messages').html('<div class="alert alert-error"><a class="close" data-dismiss="alert" href="#">x</a>' + data.message + '</div>');
    }
  });

  // 修改地址
  $('form.update_address').bind('ajax:success', function(evt, data, status, xhr){
    var messagesDiv = $(evt.currentTarget).find('div.messages');
    if (data.isSuccessful) {
      messagesDiv.html('<div class="alert alert-success"><a class="close" data-dismiss="alert" href="#">x</a>' + data.message + '</div>');
      document.location.reload();
    }
    else {
      messagesDiv.html('<div class="alert alert-error"><a class="close" data-dismiss="alert" href="#">x</a>' + data.message + '</div>');
    }
  });
});
