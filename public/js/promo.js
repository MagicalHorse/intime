 function ajaxRead()
    {   var html = '';
        $.ajax({
        url:"http://stage.youhuiin.com/comment/get_list.json ",
        dataType:"jsonp",
        success:function(data){
		  var i=0, length=data.datas.length;
		  var html = "";
			   for(;i<length;i++){
				    html+='<li class="post">';
						html+='<div class="post-self">';
							html+='<div class="avatar"><a rel="nofollow author" href="#" title="龚飞"><img src="temp/noavatar_default.png" alt="龚飞"></a></div>';
							html+='<div class="comment-body">';
								html+='<div class="comment-header"><a class="user-name highlight" rel="nofollow" target="_blank">龚飞</a></div>';
								html+='<p>'+data.datas[i].content+'</p>';
								html+='<div class="comment-footer comment-actions"><span class="time" datetime="2013-09-05T10:27:03+08:00" title="2013年9月5日 上午10:27:03">4小时前 - 2楼</span><a class="post-reply" href="javascript:void(0);"><span class="icon icon-reply"></span>回复</a></div>';
							html+='</div>';
						html+='</div>';
						var c=0, leng =data.datas[i].comments.length;
						if(leng != 0) {
									 for(;c<leng;c++) {
							       html+='<ul class="children">';
												html+='<li class="post">';
													html+='<div class="post-self">';
														html+='<div class="avatar"><a rel="nofollow author" href="#" title="Lengxu"><img src="temp/noavatar_default.png" alt="Lengxu"></a></div>';
														html+='<div class="comment-body">';
															html+='<div class="comment-header"><a class="user-name highlight" href="#" rel="nofollow" target="_blank">Lengxu</a></div>';
															html+='<p>'+data.datas[i].comments[c].content+'</p>';
															html+='<div class="comment-footer comment-actions"><span class="time" datetime="2013-09-05T10:27:15+08:00" title="2013年9月5日 上午10:27:15">4小时前</span><a class="post-reply" href="javascript:void(0);"><span class="icon icon-reply"></span>回复</a></div>';
														html+='</div>';
													html+='</div>';
												html+='</li>';
						         html+='</ul>';
							     }
							}
					html+='</li>';
				   }
			  $('#comment_list').append(html);
			 ////////////////////////////////////////////////
        }
   });
    }
	function show()
    {

        if($(window).scrollTop()+$(window).height()>=$(document).height())
        {
            ajaxRead();
        }
    }
$(document).ready(new function() {
         ajaxRead();	
		$(window).bind('scroll',function(){show()});
});