// 主要是详情页的喜欢、优惠码、评论、分享
/**
$(document).ready(new function() {
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

})
**/
