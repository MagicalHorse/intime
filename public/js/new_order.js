function generateTipsHtml(result) {
  if (result.isSuccessful) {
    var html = [];
    html.push('<div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><h3 id="mLabel">订单已提交！</h3></div>');
    html.push('<div class="modal-body"><p style="line-height:30px;text-align:center">订单编号：');
    html.push(result.data.orderno);
    html.push('</p><p style="font-size:12px;text-align:center;"><span style="color:#990000">请在24小时内完成支付，过时订单将会自动取消！</span></p>/div');
    html.push('<div class="modal-footer"><a href="/front/orders/');
    html.push(result.data.orderno);
    html.push('" class="btn btn-danger" >查看订单</a><a id="payment" class="btn btn-danger" orderno="');
    html.push(result.data.orderno);
    html.push('" data-dismiss="modal">在线支付</a>');
    return html.join('');
  }
  else {
  }
}

$(document).ready(function() {
  $('#order_commit').click(function() {
    $.post('/fonts/orders', {}, function(result) {
      $('div#barcode012').html(generateTipsHtml(result));
    }).done(function() {
      $('div#barcode012').show();
    });
  });

  $('a#payment').live('click', function() {
    alert($(this).attr('orderno'));
  });
});
