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

      var handler = null,
          page = 1,
          isLoading = false,
          apiURL = 'http://stage.youhuiin.com/promotion/get_list.json';

      // Prepare layout options.
      var options = {
        autoResize: true, // This will auto-update the layout when the browser window is resized.
        container: $('#tiles'), // Optional, used for some extra CSS styling
        offset: 8, // Optional, the distance between grid items
        //itemWidth: 210 // Optional, the width of a grid item
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
        options.container.imagesLoaded(function() {
          // Create a new layout handler when images have loaded.
          handler = $('#tiles li');
          handler.wookmark(options);
        });
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
				if(length!=0){
					for(; i<length; i++) {
        if(sort==1){
			html+='<li>';
							html+='<div class="thumbnail">';
								html+='<h3><i class="icon_title"></i><a href="promo.html" title="">'+data.datas[i].title+'</a></h3>';
								html+='<div class="action"> <a href="promo.html"><img src="'+data.datas[i].imageUrl+'" alt=" "></a>';
									html+='<p>喜欢银泰，乐享三倍积点。银泰年中庆，小积点也能玩出大动作，三倍积点大赠送啦！</p>';
								html+='</div>';
								html+='<h3 class="time bottom">活动时间：<span>'+data.datas[i].startDate+'-'+data.datas[i].endDate+'</span></h3>';
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
						html+='</li>';
		}else if(sort==2) {
			html+='<li>';
							html+='<div class="thumbnail">';
								html+='<h3 class="time">活动时间：<span>'+data.datas[i].startDate+'-'+data.datas[i].endDate+'</span></h3>';
								html+='<div class="action"> <a href="#"><img src="'+data.datas[i].imageUrl+'" alt=" "></a>';
									html+='<p>喜欢银泰，乐享三倍积点。银泰年中庆，小积点也能玩出大动作，三倍积点大赠送啦！</p>';
								html+='</div>';
								html+='<h3 class="bottom"><i class="icon_title"></i><a href="#" title="">'+data.datas[i].title+'</a></h3>';
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
						html+='</li>';
		} else if(sort==3) {
			html+='<li>';
							html+='<div class="thumbnail">';
								html+='<h3><i class="icon_title"></i><a href="promo.html" title="">'+data.datas[i].title+'</a></h3>';
								html+='<div class="action"> <a href="promo.html"><img src="'+data.datas[i].imageUrl+'" alt=" "></a>';
									html+='<p>喜欢银泰，乐享三倍积点。银泰年中庆，小积点也能玩出大动作，三倍积点大赠送啦！</p>';
								html+='</div>';
								html+='<h3 class="time bottom">活动时间：<span>'+data.datas[i].startDate+'-'+data.datas[i].endDate+'</span></h3>';
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
						html+='</li>';
			}
      }
					} else {
						html ='<p style="text-align:center;font-size: 16px;line-height:30px;">更多精彩活动敬请期待！</p>';
						}
        // Add image HTML to the page.
        $('#tiles').append(html);

        // Apply layout.
        applyLayout();
      };
	   function clears() {
		page =1;
		$('#tiles').empty();
		}
       $(document).ready(new function() {
      // Capture scroll event.
      $(document).bind('scroll', onScroll);

      // Load first data from the API.
      loadData('3');
									  });
   