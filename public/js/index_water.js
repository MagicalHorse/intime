//首页广告图
$('#banner').royalSlider({
	//arrowsNav: false,是否用箭头导航,默认true
	loop: true,//是否从最后一张幻灯片滑动到第一张
	controlsInside: false,
	imageScaleMode: 'fill',//图片缩放模式	“fill”, “fit”, “fit-if-smaller” 或 “none”
	autoScaleSlider: true,//是否基于基础宽度自动更新滑块高度	true或false
	arrowsNavHideOnTouch: true,//箭头导航是否在触摸设备中隐藏 true或fa
	autoScaleSliderWidth: 880,//幻灯片基础宽度   
	autoScaleSliderHeight: 300,//幻灯片基础高度
	slidesSpacing: 0,//幻灯片之间的间隔，单位px
	controlNavigation: 'bullets',//导航类型	‘bullets’, ‘thumbnails’, ‘tabs’ 或 ‘none’
	navigateByClick: true,//是否允许在幻灯片上点击鼠标导航	true或false
	autoPlay: {
		// autoplay options go gere
		enabled: true,
		pauseOnHover: true
	},
	transitionType:'move',//切换过渡类型	‘move’ 或 ‘fade’
});


   var handler = null;
    var page = 1;
    var isLoading = false;
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    var apiURL = 'http://stage.youhuiin.com/promotion/get_list.json'
=======
    var apiURL = 'http://stage.youhuiin.com/front/promotions/get_list.json'
>>>>>>> 添加我的优惠券、我的兑换券、积点兑换页面
=======
    var apiURL = 'http://stage.youhuiin.com/promotion/get_list.json'
>>>>>>> update js and css
=======
    var apiURL = 'http://stage.youhuiin.com/front/promotions/get_list.json'
>>>>>>> 完善积点兑换
=======
    var apiURL = 'http://stage.youhuiin.com/promotion/get_list.json'
>>>>>>> 更新js css
=======
    var apiURL = 'http://stage.youhuiin.com/front/promotions/get_list.json'
>>>>>>> 完善页面展示
=======
    var apiURL = 'http://stage.youhuiin.com/promotion/get_list.json'
>>>>>>> 提交订单页
    
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
          loadData(sort);
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
    function loadData($type) {
      isLoading = true;
      $('#loaderCircle').show();
      sort = $type;
      $.ajax({
        url: apiURL,
        dataType: 'jsonp',
        data: {page: page,sort:sort}, // Page parameter to make sure we load new data
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
      
      // Create HTML for the images.
      var html = '';
      var i=0, length=data.datas.length;
      for(; i<length; i++) {
        if(sort==1){
			html+='<li>';
							html+='<div class="thumbnail">';
								html+='<h3><i class="icon_title"></i><a href="promo.html" title="">'+data.datas[i].title+'</a></h3>';
								html+='<div class="action"> <a href="promo.html"><img src="'+data.datas[i].imageUrl+'" alt=" "></a>';
									html+='<p>喜欢银泰，乐享三倍积点。银泰年中庆，小积点也能玩出大动作，三倍积点大赠送啦！</p>';
								html+='</div>';
								html+='<h3 class="time bottom">活动时间：<span>'+data.datas[i].startDate+'-'+data.datas[i].endDate+'</span></h3>';
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
=======
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> update js and css
=======
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 完善积点兑换
=======
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 更新js css
=======
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 完善页面展示
=======
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 提交订单页
						html+='</li>';
		}else if(sort==2) {
			html+='<li>';
							html+='<div class="thumbnail">';
								html+='<h3 class="time">活动时间：<span>'+data.datas[i].startDate+'-'+data.datas[i].endDate+'</span></h3>';
								html+='<div class="action"> <a href="#"><img src="'+data.datas[i].imageUrl+'" alt=" "></a>';
									html+='<p>喜欢银泰，乐享三倍积点。银泰年中庆，小积点也能玩出大动作，三倍积点大赠送啦！</p>';
								html+='</div>';
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
								html+='<h3 class="bottom"><i class="icon_title"></i><a href="#" title="">'+data.datas[i].title+'</a></h3>';
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
=======
								html+='<h3 class="bottom"><i class="icon_title"></i><a href="'+data.datas[i].url+'" title="">'+data.datas[i].title+'</a></h3>';
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 添加我的优惠券、我的兑换券、积点兑换页面
=======
								html+='<h3 class="bottom"><i class="icon_title"></i><a href="#" title="">'+data.datas[i].title+'</a></h3>';
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> update js and css
=======
								html+='<h3 class="bottom"><i class="icon_title"></i><a href="'+data.datas[i].url+'" title="">'+data.datas[i].title+'</a></h3>';
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 完善积点兑换
=======
								html+='<h3 class="bottom"><i class="icon_title"></i><a href="#" title="">'+data.datas[i].title+'</a></h3>';
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 更新js css
=======
								html+='<h3 class="bottom"><i class="icon_title"></i><a href="'+data.datas[i].url+'" title="">'+data.datas[i].title+'</a></h3>';
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 完善页面展示
=======
								html+='<h3 class="bottom"><i class="icon_title"></i><a href="#" title="">'+data.datas[i].title+'</a></h3>';
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 提交订单页
						html+='</li>';
		} else if(sort==3) {
			html+='<li>';
							html+='<div class="thumbnail">';
								html+='<h3><i class="icon_title"></i><a href="promo.html" title="">'+data.datas[i].title+'</a></h3>';
								html+='<div class="action"> <a href="promo.html"><img src="'+data.datas[i].imageUrl+'" alt=" "></a>';
									html+='<p>喜欢银泰，乐享三倍积点。银泰年中庆，小积点也能玩出大动作，三倍积点大赠送啦！</p>';
								html+='</div>';
								html+='<h3 class="time bottom">活动时间：<span>'+data.datas[i].startDate+'-'+data.datas[i].endDate+'</span></h3>';
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
=======
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> update js and css
=======
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 完善积点兑换
=======
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 更新js css
=======
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 完善页面展示
=======
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 提交订单页
						html+='</li>';
			}
      }
      
      // Add image HTML to the page.
      $('#tiles_lsit').append(html);
      
      // Apply layout.
      applyLayout();
    };
    function clears() {
		page =1;
		$('#tiles_lsit').empty();
		}
    $(document).ready(new function() {
      // Capture scroll event.
      $(document).bind('scroll', onScroll);
      
      // Load first data from the API.
      loadData('3');
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    });
=======
    });
>>>>>>> update js and css
=======
    });
>>>>>>> 完善积点兑换
=======
    });
>>>>>>> 更新js css
=======
    });
>>>>>>> 完善页面展示
=======
    });
>>>>>>> 提交订单页
