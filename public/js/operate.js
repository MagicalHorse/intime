// 主要是详情页的喜欢、优惠码、评论、分享
$(document).ready(new function() {
  $(document).ajaxSend(function(){
    if($.cookie('login') == null){
      window.location.replace("http://www.intime.com.cn/login?return_to="+$(location).attr('href'))
    }
  })
  $('.func .favor').click(function(){
  })
})
