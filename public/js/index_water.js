<<<<<<< HEAD
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

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
   var handler = null;
    var page = 1;
    var isLoading = false;
<<<<<<< HEAD
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
=======
    var apiURL = 'http://stage.youhuiin.com/front/promotions/get_list.json'
>>>>>>> fix bug
=======
   var handler = null;
    var page = 1;
    var isLoading = false;
    var apiURL = 'http://stage.youhuiin.com/front/promotions/get_list.json'
>>>>>>> 调试促销详情页评论
    
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
<<<<<<< HEAD
=======
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
>>>>>>> update js and css
=======
>>>>>>> 调试促销详情页评论
=======
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
>>>>>>> 更新首页js
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
=======
window.intime = window.intime || {};
intime = window.intime;
$.extend(intime, {
	index: {
		_page: 1,
		_sort: '',
		_listpath: 'front/promotions/get_list.json',
		_container: $('#tiles'),
		_msnry: null,
		_isMsnryInit: false,
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

			var elems = [];
			var fragment = document.createDocumentFragment();
<<<<<<< HEAD


			  for ( ; i < length; i++ ) {

 if(sort==1){
			html+='<li class="scrollItem">';
							html+='<div class="thumbnail">';
								html+='<h3><i class="icon_title"></i><a href="'+data.datas[i].url+'" title="">'+data.datas[i].title+'</a></h3>';
								html+='<div class="action"> <a href="'+data.datas[i].url+'"><img src="'+data.datas[i].imageUrl+'" alt=" "></a>';
									html+='<p>'+data.datas[i].description+'</p>';
								html+='</div>';
								html+='<h3 class="time bottom">活动时间：<span>'+data.datas[i].startDate+'-'+data.datas[i].endDate+'</span></h3>';
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> fix bug
=======
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> update js and css
=======
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 调试促销详情页评论
=======
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 更新首页js
=======
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 修改首页展示信息
						html+='</li>';
		}else if(sort==2) {
			html+='<li class="scrollItem">';
							html+='<div class="thumbnail">';
								html+='<h3 class="time">活动时间：<span>'+data.datas[i].startDate+'-'+data.datas[i].endDate+'</span></h3>';
								html+='<div class="action"> <a href="'+data.datas[i].url+'"><img src="'+data.datas[i].imageUrl+'" alt=" "></a>';
									html+='<p>'+data.datas[i].description+'</p>';
								html+='</div>';
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
								html+='<h3 class="bottom"><i class="icon_title"></i><a href="'+data.datas[i].url+'" title="">'+data.datas[i].title+'</a></h3>';
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> fix bug
=======
								html+='<h3 class="bottom"><i class="icon_title"></i><a href="#" title="">'+data.datas[i].title+'</a></h3>';
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> update js and css
=======
								html+='<h3 class="bottom"><i class="icon_title"></i><a href="'+data.datas[i].url+'" title="">'+data.datas[i].title+'</a></h3>';
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 调试促销详情页评论
=======
								html+='<h3 class="bottom"><i class="icon_title"></i><a href="#" title="">'+data.datas[i].title+'</a></h3>';
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 更新首页js
=======
								html+='<h3 class="bottom"><i class="icon_title"></i><a href="'+data.datas[i].url+'" title="">'+data.datas[i].title+'</a></h3>';
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 修改首页展示信息
						html+='</li>';
		} else if(sort==3) {
			html+='<li class="scrollItem">';
							html+='<div class="thumbnail">';
								html+='<h3><i class="icon_title"></i><a href="'+data.datas[i].url+'" title="">'+data.datas[i].title+'</a></h3>';
								html+='<div class="action"> <a href="'+data.datas[i].url+'"><img src="'+data.datas[i].imageUrl+'" alt=" "></a>';
									html+='<p>'+data.datas[i].description+'</p>';
								html+='</div>';
								html+='<h3 class="time bottom">活动时间：<span>'+data.datas[i].startDate+'-'+data.datas[i].endDate+'</span></h3>';
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> fix bug
=======
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> update js and css
=======
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 调试促销详情页评论
=======
								html+='<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 更新首页js
=======
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
>>>>>>> 修改首页展示信息
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
=======
			if (sort == 1) {
				$(data.datas).each(function() {
					var html = '';
					var one = this;
					html += '<li class="scrollItem">';
					html += '<div class="thumbnail">';
					html += '<h3><i class="icon_title"></i><a href="' + one.url + '" title="">' + one.title + '</a></h3>';
					html += '<div class="action"> <a href="promo.html"><img src="' + one.imageUrl + '" alt=" "></a>';
					html += '<p>喜欢银泰，乐享三倍积点。银泰年中庆，小积点也能玩出大动作，三倍积点大赠送啦！</p>';
					html += '</div>';
					html += '<h3 class="time bottom">活动时间：<span>' + one.startDate + '-' + one.endDate + '</span></h3>';
					html += '<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>' + one.storeName + '</a></span> <span class="pull-right"><i class="icon-heart"></i>' + one.likeCount + '+</span> </small> </div>';
					html += '</li>';
					var elem = $(html).get(0);
					fragment.appendChild(elem);
					elems.push(elem);
				});
			} else if (sort == 2) {
				$(data.datas).each(function() {
					var html = '';
					var one = this;
					html += '<li class="scrollItem">';
					html += '<div class="thumbnail">';
					html += '<h3 class="time">活动时间：<span>' + one.startDate + '-' + one.endDate + '</span></h3>';
					html += '<div class="action"> <a href="#"><img src="' + one.imageUrl + '" alt=" "></a>';
					html += '<p>喜欢银泰，乐享三倍积点。银泰年中庆，小积点也能玩出大动作，三倍积点大赠送啦！</p>';
					html += '</div>';
					html += '<h3 class="bottom"><i class="icon_title"></i><a href="' + one.url + '" title="">' + one.title + '</a></h3>';
					html += '<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>' + one.storeName + '</a></span> <span class="pull-right"><i class="icon-heart"></i>' + one.likeCount + '+</span> </small> </div>';
					html += '</li>';
					var elem = $(html).get(0);
					fragment.appendChild(elem);
					elems.push(elem);
>>>>>>> update blank prompt
				});
			} else if (sort == 3) {
				$(data.datas).each(function() {
					var html = '';
					var one = this;
					html += '<li class="scrollItem">';
					html += '<div class="thumbnail">';
					html += '<h3><i class="icon_title"></i><a href="' + one.url + '" title="">' + one.title + '</a></h3>';
					html += '<div class="action"> <a href="promo.html"><img src="' + one.imageUrl + '" alt=" "></a>';
					html += '<p>喜欢银泰，乐享三倍积点。银泰年中庆，小积点也能玩出大动作，三倍积点大赠送啦！</p>';
					html += '</div>';
					html += '<h3 class="time bottom">活动时间：<span>' + one.startDate + '-' + one.endDate + '</span></h3>';
					html += '<small> <span class="pull-left"><a href="shop.html"><i class="icon-map-marker"></i>' + one.storeName + '</a></span> <span class="pull-right"><i class="icon-heart"></i>' + one.likeCount + '+</span> </small> </div>';
					html += '</li>';
					var elem = $(html).get(0);
					fragment.appendChild(elem);
					elems.push(elem);
				});
			}

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
		loadData: function($sort) {
			this._isLoadingMore = true;
			$('#loader').show();
			$('#no_data,#last_page').hide();
			var _this = this;
			sort = $sort;
			$.ajax({
				url: this.listUrl(),
				dataType: 'jsonp',
				data: {
					page: this._page,
					sort: $sort
				},
				success: this.onLoad
			}).always(function() {
				_this._isLoadingMore = false;
				$('#loader').hide();
			});

<<<<<<< HEAD
      // Load first data from the API.
      loadData('3');
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
    });
>>>>>>> fix bug
=======
									  });
   
>>>>>>> update js and css
=======
    });
>>>>>>> 调试促销详情页评论
=======
									  });
>>>>>>> 更新首页js
=======
									  });
>>>>>>> 修改首页展示信息
=======
		},
		clears: function() {
			this._page = 1;
			$('#no_data,#last_page').hide();
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
					_this.loadData(sort);
				}
			}
		},
		listUrl: function() {
			return intime.env.host + this._listpath;
		}
	}
});
>>>>>>> update blank prompt
