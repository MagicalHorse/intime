$(document).ready(new function() {
  $('a#cancel').on('click', function() {
    if (confirm('是否确定要取消订单？')) {
      $.post("/front/orders/" + $(this).attr('data-order-id'), { _method: 'delete' }, function(result) {
        if (result.isSuccessful) {
          $('#order_status').html('取消');
          $('a#cancel').remove();
          var payment =  $('a#payment');
          if (payment)
            payment.remove();
        }
        else
          alert(result.message);
      });
    }
    else
      return false;
  });
});
