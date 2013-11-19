<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> update js and css
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
function get_source(){
  var str =$('.promo_info').attr('info');
  var strs= new Array(); //定义一数组
  strs=str.split(","); //字符分割
  sourcetype = strs[0];
  sourceid = strs[1];
}
=======
window.intime = window.intime || {};
intime = window.intime;
$.extend(intime, {
	index: {
		_page: 1,
		_sort: '',
		_listpath: 'front/comments/get_list.json',
		_container: $('#tiles'),
		_msnry: null,
		_isMsnryInit: true,
		_isLoadingMore: false,
>>>>>>> update blank prompt

		onLoad: function(data) {
			var _this = intime.index;
			var length = data.datas.length;
			if (_this._page == 1) {
				if (length <= 0) {
					$('#no_data').show();
					return;
				}
			} else {
				if (length <= 0) {
					$('#last_page').show();
					return;
				}
			}
			_this._page++;
			var num = data.totalcount;
	        $('#totalcount').html('('+num+')');
			if (length <= 0) return;
			var elems = [];
			var fragment = document.createDocumentFragment();
			$(data.datas).each(function() {
				var html = '';
				var one = this;
				leng = one.comments.length;
				html += '<li class="post scrollItem" id="reply_'+one.commentId+'">';
				html += '<div class="post-self">';
				html += '<div class="avatar"><a rel="nofollow author" href="'+one.customer.url+'" title="' + one.customer.nickname + '"><img src="' + one.customer.logo + '" alt="' + one.customer.nickname + '"></a></div>';
				html += '<div class="comment-body">';
				html += '<div class="comment-header"><a class="user-name highlight" href="'+one.customer.url+'" rel="nofollow" target="_blank">' + one.customer.nickname + '</a></div>';
				html += '<p>' + one.content + '</p>';
				html += '<div class="comment-footer comment-actions"><span class="time" datetime="' + one.createTime + '" title="' + one.createTime + '">' + one.createTime + '</span><a class="post-reply" href="#reply" data-toggle="modal" onclick="reply_comment(\''+one.commentId+'\', \''+one.customer.nickname+'\')"><span class="icon icon-reply"></span>回复</a></div>';
				html += '</div>';
				html += '</div>';
				var c = 0,
				leng = one.comments.length;
				if (leng != 0) {
					for (; c < leng; c++) {
						html += '<ul class="children">';
						html += '<li class="post">';
						html += '<div class="post-self">';
						html += '<div class="avatar"><a rel="nofollow author" href="'+one.customer.url+'" title="Lengxu"><img src="' + one.comments[c].customer.logo + '" alt="' + one.comments[c].customer.nickname + '"></a></div>';
						html += '<div class="comment-body">';
						html += '<div class="comment-header"><a class="user-name highlight" href="'+one.customer.url+'" rel="nofollow" target="_blank">' + one.comments[c].customer.nickname + '</a></div>';
						html += '<p>' + one.comments[c].content + '</p>';
						html += '<div class="comment-footer comment-actions"><span class="time" datetime="' + one.comments[c].createTime + '" title="' + one.comments[c].createTime + '">' + one.comments[c].createTime + '</span></div>';
						html += '</div>';
						html += '</div>';
						html += '</li>';
						html += '</ul>';
					}
				}
				html += '</li>';

				var elem = $(html).get(0);
				fragment.appendChild(elem);
				elems.push(elem);
			});
			_this._container.append(fragment);
			_this._container.imagesLoaded(function() {
				if (!_this._isMsnryInit) {
					_this._isMsnryInit = true;
					_this._msnry = new Masonry(_this._container[0], {
						itemSelector: '.scrollItem'
					});
				} else {
					_this._msnry.appended(elems);
				}
			});
		},
		loadData: function($sourceid,$sourcetype) {
			this._isLoadingMore = true;
			$('#loader').show();
			$('#no_data,#last_page').hide();
			var _this = this;
			sourceid = $sourceid;
			sourcetype = $sourcetype;
			$.ajax({
				url: this.listUrl(),
				dataType: 'jsonp',
				data: {
					page: this._page,
					sourceid: sourceid,
					sourcetype: sourcetype
				},
				success: this.onLoad
			}).always(function() {
				_this._isLoadingMore = false;
				$('#loader').hide();
			});

		},
		clears: function() {

<<<<<<< HEAD
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
    data: {page: page,sourcetype:sourcetype,sourceid:sourceid}, // Page parameter to make sure we load new data
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
  $('.distance').html('('+num+')');
  var html = "";
  ///////////////////////////////////////////
  for(;i<length;i++){
    html+='<li class="post">';
    html+='<div class="post-self">';
    html+='<div class="avatar"><a rel="nofollow author" href="'+data.datas[i].customer.url+'" title="'+data.datas[i].customer.nickname+'"><img src="'+data.datas[i].customer.logo+'" alt="'+data.datas[i].customer.nickname+'"></a></div>';
    html+='<div class="comment-body">';
    html+='<div class="comment-header"><a class="user-name highlight" rel="nofollow" target="_blank">'+data.datas[i].customer.nickname+'</a></div>';
    html+='<p>'+data.datas[i].content+'</p>';
    html+='<div class="comment-footer comment-actions"><span class="time" datetime="'+data.datas[i].createTime+'" title="'+data.datas[i].createTime+'">'+data.datas[i].createTime+' - '+data.datas[i].floor+'楼</span><a class="post-reply" href="javascript:void(0);"><span class="icon icon-reply"></span>回复</a></div>';
    html+='</div>';
    html+='</div>';
    var c=0, leng =data.datas[i].comments.length;
    if(leng != 0) {
      for(;c<leng;c++) {
        html+='<ul class="children">';
        html+='<li class="post">';
        html+='<div class="post-self">';
        html+='<div class="avatar"><a rel="nofollow author" href="'+data.datas[i].customer.url+'" title="'+data.datas[i].comments[c].customer.nickname+'"><img src="'+data.datas[i].comments[c].customer.logo+'" alt="'+data.datas[i].comments[c].customer.nickname+'"></a></div>';
        html+='<div class="comment-body">';
        html+='<div class="comment-header"><a class="user-name highlight" href="#" rel="nofollow" target="_blank">'+data.datas[i].comments[c].customer.nickname+'</a></div>';
        html+='<p>'+data.datas[i].comments[c].content+'</p>';
        html+='<div class="comment-footer comment-actions"><span class="time" datetime="'+data.datas[i].comments[c].createTime+'" title="'+data.datas[i].comments[c].createTime+'">'+data.datas[i].comments[c].createTime+'</span><a class="post-reply" href="javascript:void(0);"><span class="icon icon-reply"></span>回复</a></div>';
        html+='</div>';
        html+='</div>';
        html+='</li>';
        html+='</ul>';
      }
<<<<<<< HEAD
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
	  //sourcetype = $sourcetype;
      //sourceid = $sourceid;
      $.ajax({
        url: apiURL,
        dataType: 'jsonp',
        data: {page: page,sourcetype:sourcetype,sourceid:sourceid}, // Page parameter to make sure we load new data
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
								html+='<div class="comment-footer comment-actions"><span class="time" datetime="2013-09-05T10:27:03+08:00" title="2013年9月5日 上午10:27:03">'+data.datas[i].createTime+' - 2楼</span><a class="post-reply" href="javascript:void(0);"><span class="icon icon-reply"></span>回复</a></div>';
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
  function get_source(){
	    var str =$('#promo_info').attr('info');
	    var strs= new Array(); //定义一数组
		strs=str.split(","); //字符分割      
				//document.write(strs[i]+"<br/>");    //分割后的字符输
				sourcetype = strs[0];
				sourceid = strs[1];
				//alert(sourcetype);
				//alert(sourceid);
	  }
    $(document).ready(new function() {
      // Capture scroll event.
      $(document).bind('scroll', onScroll);
      get_source();
      // Load first data from the API.
<<<<<<< HEAD
      loadData();
<<<<<<< HEAD
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
=======
    });
>>>>>>> update js and css
=======
      loadData(sourcetype,sourceid);
<<<<<<< HEAD
<<<<<<< HEAD
    });
>>>>>>> 更新js css
=======
    });
>>>>>>> 完善页面展示
=======
    });
>>>>>>> 提交订单页
=======
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
  get_source();
  // Load first data from the API.
  loadData();
});
>>>>>>> 调试促销详情页评论
=======
			this._page = 1;
			this._container.empty();
			if (this._msnry) {
				var items = this._msnry.getItemElements();
				if (items && items.length > 0) {
					this._msnry.remove(items);
					this._isMsnryInit = false;
					this._msnry.destroy();
				}
			}
		},
		onScroll: function(event) {
			// Only check when we're not still waiting for data.
			var _this = intime.index;
			if (!_this._isLoadingMore) {
				// Check if we're within 100 pixels of the bottom edge of the broser window.
				var closeToBottom = ($(window).scrollTop() + $(window).height() > $(document).height() - 100);
				if (closeToBottom) {
					_this.loadData(sourceid,sourcetype);
				}
			}
		},
		listUrl: function() {
			return intime.env.host + this._listpath;
		}
	}
<<<<<<< HEAD
});
>>>>>>> update blank prompt
=======
});
>>>>>>> 完善详情页评论
