// 主要是详情页的喜欢、优惠码、评论、分享
$(document).ready(new function() {
  /**
  function reloadWithoutLogin(){
    if($.cookie('login') == null){
      window.location.replace("/login?return_to="+$(location).attr('href'))
    }
  }
  $('.func .favor').click(function(){
    reloadWithoutLogin();
  })
  $('.func .unfavor').click(function(){
    reloadWithoutLogin();
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
    defaultVal = $(this).attr('placeholder');
    if(($('.currentScore').html() - curVal) <= 0){
      alert('兑换积点需大于最小积点限制');
    }else{
      $.post('/front/storepromotions/'+$(this).attr('info')+'/amount', {points: curVal}, function(data){
        $('.money').html(data.amount + '元')
      })
    }
  })

  $('#exchange').click(function(){
    score = $('#points').val();
    unitScore = $('#points').attr('placeholder');
    if($('select[name=storeid]').val()=='0'){
      alert('请选择使用门店');
      return false;
    }
    if(($('.currentScore').html() - score) < 0){
      alert('兑换积点需大于最小积点限制');
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
