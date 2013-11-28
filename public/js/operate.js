// 主要是详情页的喜欢、优惠码、评论、分享
$(document).ready(new function() {

  /**
  $('.func .favor').on('ajax:beforeSend', function(){
    $(this).html('<img alt="Icon_hearts_2x" height="24" src="/images/icon_hearts_2x.png" width="24"><span>取消</span>')
    $('.code .likecount').html(parseInt($('.code .likecount').html()) + 1)
  })
  $('.func .unfavor').on('ajax:beforeSend', function(){
    $(this).html('<img alt="Icon_heart_2x" height="24" src="/images/icon_heart_2x.png" width="24"><span>喜欢</span>')
    $('.code .downcount').html(parseInt($('.code .downcount').html()) - 1)
  })

  $('#show_comment').click(function(){
    reloadWithoutLogin();
    $('#post').modal('show');
  })

  $('#comment').click(function(){
    //$(this).attr('disabled', true);
  })
  **/

  $('#points').change(function(){
    curVal = $(this).val();
    defaultVal = $(this).attr('amount');
    if(($('.currentScore').html() - curVal) < 0){
      alert('当前可用积点不足');
    }else{
      $.post('/front/storepromotions/'+$(this).attr('info')+'/amount', {points: curVal}, function(data){
        $('.money').html(data.amount + '元')
      })
    }
  })

  $('#exchange').click(function(){
    score = $('#points').val();
    unitScore = $('#points').attr('amount');
    if($('select[name=storeid]').val()=='0'){
      alert('请选择使用门店');
      return false;
    }
    if(($('.currentScore').html() - score) < 0){
      alert('当前可用积点不足');
      return false;
    }
    if(score == 0 || score%unitScore != 0){
      alert('兑换积点必须是'+unitScore+'的整数倍');
      return false;
    }

    if($('#identityno').val() == ''){
      alert('请输入登记的身份证号');
      return false;
    }
  })

})

function reply_comment(id, userName){
  $('.modal-header #mLabel').html('回复`'+userName+'`');
  $('#sourceid').val(id);
}
