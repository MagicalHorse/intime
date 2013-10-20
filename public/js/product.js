<<<<<<< HEAD
//产品页面图片
$('#picbox').royalSlider({
	loop: true,
	controlsInside: false,
	imageScaleMode: 'fill',
	arrowsNavAutoHide: true,//箭头导航是否自动隐藏	true或false
	arrowsNavHideOnTouch: true,//箭头导航是否在触摸设备中隐藏 true或false
	autoScaleSlider: true,
	autoScaleSliderWidth: 400,  
	autoScaleSliderHeight: 400,
	slidesSpacing: 0,
	controlNavigation: 'bullets',
	navigateByClick: true,
	autoPlay: false,
	transitionType:'move'
});



var handler = null;
    var page = 1;
    var isLoading = false;
    var apiURL = 'http://stage.youhuiin.com/comment/get_list.json'
    
    // Prepare layout options.
    var options = {
      autoResize: true, // This will auto-update the layout when the browser window is resized.
      container: $('#tiles'), // Optional, used for some extra CSS styling
      offset: 2, // Optional, the distance between grid items
      itemWidth: 210 // Optional, the width of a grid item
    };
    
    /**
     * When scrolled all the way to the bottom, add more tiles.
     */
    function onScroll(event) {
      // Only check when we're not still waiting for data.
      if(!isLoading) {
        // Check if we're within 100 pixels of the bottom edge of the broser window.
        var closeToBottom = ($(window).scrollTop() + $(window).height() > $(document).height() - 100);
        if(closeToBottom) {
          loadData();
        }
      }
    };
    
    /**
     * Refreshes the layout.
     */
    function applyLayout() {
      // Clear our previous layout handler.
      if(handler) handler.wookmarkClear();
      
      // Create a new layout handler.
      handler = $('#tiles li');
      handler.wookmark(options);
    };
    
    /**
     * Loads data from the API.
     */
    function loadData() {
      isLoading = true;
      $('#loaderCircle').show();
      
      $.ajax({
        url: apiURL,
        dataType: 'jsonp',
        data: {page: page}, // Page parameter to make sure we load new data
        success: onLoadData
      });
    };
    
    /**
     * Receives data from the API, creates HTML for images and updates the layout
     */
    function onLoadData(data) {
      isLoading = false;
      $('#loaderCircle').hide();
      
      // Increment page index for future calls.
      page++;
     var i=0, length=data.datas.length;
	 var num = data.totalcount;
	 $('#id').html('('+num+')');
		  var html = "";
			 ///////////////////////////////////////////
			   for(;i<length;i++){
				    html+='<li class="post">';
						html+='<div class="post-self">';
							html+='<div class="avatar"><a rel="nofollow author" href="#" title="龚飞"><img src="temp/noavatar_default.png" alt="龚飞"></a></div>';
							html+='<div class="comment-body">';
								html+='<div class="comment-header"><a class="user-name highlight" rel="nofollow" target="_blank">'+data.datas[i].customer.nickname+'</a></div>';
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
      // Apply layout.
      applyLayout();
    };
  
    $(document).ready(new function() {
      // Capture scroll event.
      $(document).bind('scroll', onScroll);
      
      // Load first data from the API.
      loadData();
    });
=======
var handler = null;
    var page = 1;
    var isLoading = false;
    var apiURL = 'http://stage.youhuiin.com/front/comments/get_list.json'
    
    // Prepare layout options.
    var options = {
      autoResize: true, // This will auto-update the layout when the browser window is resized.
      container: $('#tiles'), // Optional, used for some extra CSS styling
      offset: 2, // Optional, the distance between grid items
      itemWidth: 210 // Optional, the width of a grid item
    };
    
    /**
     * When scrolled all the way to the bottom, add more tiles.
     */
    function onScroll(event) {
      // Only check when we're not still waiting for data.
      if(!isLoading) {
        // Check if we're within 100 pixels of the bottom edge of the broser window.
        var closeToBottom = ($(window).scrollTop() + $(window).height() > $(document).height() - 100);
        if(closeToBottom) {
          loadData();
        }
      }
    };
    
    /**
     * Refreshes the layout.
     */
    function applyLayout() {
      // Clear our previous layout handler.
      if(handler) handler.wookmarkClear();
      
      // Create a new layout handler.
      handler = $('#tiles li');
      handler.wookmark(options);
    };
    
    /**
     * Loads data from the API.
     */
    function loadData() {
      isLoading = true;
      $('#loaderCircle').show();
      
      $.ajax({
        url: apiURL,
        dataType: 'jsonp',
        data: {page: page}, // Page parameter to make sure we load new data
        success: onLoadData
      });
    };
    
    /**
     * Receives data from the API, creates HTML for images and updates the layout
     */
    function onLoadData(data) {
      isLoading = false;
      $('#loaderCircle').hide();
      
      // Increment page index for future calls.
      page++;
     var i=0, length=data.datas.length;
	 var num = data.totalcount;
	 $('#id').html('('+num+')');
		  var html = "";
			 ///////////////////////////////////////////
			   for(;i<length;i++){
				    html+='<li class="post">';
						html+='<div class="post-self">';
							html+='<div class="avatar"><a rel="nofollow author" href="#" title="龚飞"><img src="temp/noavatar_default.png" alt="龚飞"></a></div>';
							html+='<div class="comment-body">';
								html+='<div class="comment-header"><a class="user-name highlight" rel="nofollow" target="_blank">'+data.datas[i].customer.nickname+'</a></div>';
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
      // Apply layout.
      applyLayout();
    };
  
    $(document).ready(new function() {
      // Capture scroll event.
      $(document).bind('scroll', onScroll);
      
      // Load first data from the API.
      loadData();
    });
>>>>>>> 添加我的优惠券、我的兑换券、积点兑换页面
