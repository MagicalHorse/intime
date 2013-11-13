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
function clears(){
	page = 1;
	$('#tiles').empty();
	//$('#tiles').masonry('reload');
	$('#tiles').masonry('reloadItems');
	}

       var handler = null,
          page = 1,
          _isLoadingMore = false,
          apiURL = 'http://stage.youhuiin.com/front/promotions/get_list.json';

      // Prepare layout options.
     var scrollContainer = $('#tiles').masonry();
	 var msnry = scrollContainer.data('masonry');

      function onScroll(event) {
        // Only check when we're not still waiting for data.
        if(!_isLoadingMore) {
          // Check if we're within 100 pixels of the bottom edge of the broser window.
          var closeToBottom = ($(window).scrollTop() + $(window).height() > $(document).height() - 100);
          if(closeToBottom) {
            //loadData(sort);
			loadData(sort);
          }
        }
      };

      function loadData($sort) {
        _isLoadingMore = true;
        $('#loaderCircle').show();
		sort = $sort;
		//alert(sort);
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
        _isLoadingMore = false;
        $('#loaderCircle').hide();

        // Increment page index for future calls.
        page++;

          var i=0, length=data.datas.length;
			var html = '';
			if (length<=0)
			    html = '<p style="text-align:center;font-size: 16px;line-height:30px;">更多精彩活动敬请期待！</p>';
				$('#tiles').after(html);
				//alert(length);
			var elems = [];
			var fragment = document.createDocumentFragment();


			  for ( ; i < length; i++ ) {

 if(sort==1){
			html+='<li class="scrollItem">';
							html+='<div class="thumbnail">';
								html+='<h3><i class="icon_title"></i><a href="'+data.datas[i].url+'" title="">'+data.datas[i].title+'</a></h3>';
								html+='<div class="action"> <a href="'+data.datas[i].url+'"><img src="'+data.datas[i].imageUrl+'" alt=" "></a>';
									html+='<p>'+data.datas[i].description+'</p>';
								html+='</div>';
								html+='<h3 class="time bottom">活动时间：<span>'+data.datas[i].startDate+'-'+data.datas[i].endDate+'</span></h3>';
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
						html+='</li>';
		}else if(sort==2) {
			html+='<li class="scrollItem">';
							html+='<div class="thumbnail">';
								html+='<h3 class="time">活动时间：<span>'+data.datas[i].startDate+'-'+data.datas[i].endDate+'</span></h3>';
								html+='<div class="action"> <a href="'+data.datas[i].url+'"><img src="'+data.datas[i].imageUrl+'" alt=" "></a>';
									html+='<p>'+data.datas[i].description+'</p>';
								html+='</div>';
								html+='<h3 class="bottom"><i class="icon_title"></i><a href="'+data.datas[i].url+'" title="">'+data.datas[i].title+'</a></h3>';
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
						html+='</li>';
		} else if(sort==3) {
			html+='<li class="scrollItem">';
							html+='<div class="thumbnail">';
								html+='<h3><i class="icon_title"></i><a href="'+data.datas[i].url+'" title="">'+data.datas[i].title+'</a></h3>';
								html+='<div class="action"> <a href="'+data.datas[i].url+'"><img src="'+data.datas[i].imageUrl+'" alt=" "></a>';
									html+='<p>'+data.datas[i].description+'</p>';
								html+='</div>';
								html+='<h3 class="time bottom">活动时间：<span>'+data.datas[i].startDate+'-'+data.datas[i].endDate+'</span></h3>';
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
						html+='</li>';
			}
				var elem = $(html).get(i);
				fragment.appendChild(elem);
				elems.push( elem );
			  }
			
				// Start Masonry
				scrollContainer.imagesLoaded( function(){
					scrollContainer.masonry({
						itemSelector : '.scrollItem'
					});
				});

				scrollContainer.append(fragment);
				msnry.appended(elems);
      };
	   
       $(document).ready(new function() {
      // Capture scroll event.
      $(document).bind('scroll', onScroll);

      // Load first data from the API.
      loadData('3');
									  });
