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

    var apiURL = 'http://stage.youhuiin.com/front/products/my_favorite_api.json'
=======
    var apiURL = 'http://stage.youhuiin.com/front/products/my_favorite_api.json'
    //var apiURL = 'http://www.intime.com.cn:3000/front/products/my_favorite_api.json'
>>>>>>> 我的银泰页面完成
=======
    var apiURL = 'http://stage.youhuiin.com/profile/get_list.json'
>>>>>>> update js and css
=======
    var apiURL = 'http://stage.youhuiin.com/front/products/my_favorite_api.json'
=======
    //var apiURL = 'http://stage.youhuiin.com/front/products/my_favorite_api.json'
    var apiURL = 'http://www.intime.com.cn:3000/front/products/my_favorite_api.json'
>>>>>>> 增加js里面 商品url
=======
    var apiURL = 'http://stage.youhuiin.com/front/products/my_favorite_api.json'
>>>>>>> 我的主页，增加用户信息

>>>>>>> 他的页面
    
    // Prepare layout options.
    var options = {
      autoResize: true, // This will auto-update the layout when the browser window is resized.
      container: $('#tiles'), // Optional, used for some extra CSS styling
      offset: 2, // Optional, the distance between grid items
      itemWidth: 290 // Optional, the width of a grid item
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
          loadData(loveType);
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
<<<<<<< HEAD

       loveType = $type;

=======
	  loveType = $type;
>>>>>>> 我的银泰页面完成
      $('#loaderCircle').show();
      
      $.ajax({
        url: apiURL,
        dataType: 'jsonp',
<<<<<<< HEAD

        data: {page: page,'loveType':loveType}, // Page parameter to make sure we load new data

=======
        data: {page: page,loveType:loveType}, // Page parameter to make sure we load new data
>>>>>>> 我的银泰页面完成
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
<<<<<<< HEAD

      var html = '';

=======
     var html = '';
>>>>>>> 我的银泰页面完成
      var i=0, length=data.datas.length;
      for(; i<length; i++) {
       html+='<li>';
						html+='<div class="thumbnail">';
							html+='<div class="action">';
<<<<<<< HEAD
<<<<<<< HEAD

								html+='<a href="product.html"><img src="'+data.datas[i].imageUrl+'" alt="'+data.datas[i].imageUrl+'"></a>';
=======
								html+='<a href="'+data.datas[i].url+'"><img src="'+data.datas[i].imageUrl+'" alt="'+data.datas[i].imageUrl+'"></a>';
>>>>>>> 增加js里面 商品url
								html+='<span class="like"><i class="icon-heart icon-white"></i>'+data.datas[i].likeCount+'+</span>';

=======
								html+='<a href="product.html"><img src="'+data.datas[i].imageUrl+'" alt="'+data.datas[i].imageUrl+'"></a>';
								html+='<span class="like"><i class="icon-heart icon-white"></i>'+data.datas[i].likeCount+'+</span>';
>>>>>>> 我的银泰页面完成
							html+='</div>';
							html+='<h4><a href="'+data.datas[i].url+'">'+data.datas[i].title+'</a></h4>';
							html+='<small><span class="pull-left num">吊牌价：<em>￥'+data.datas[i].originalPrice+'</em></span><span class="pull-right price">销售价：<em>￥'+data.datas[i].price+'</em></span></small>';
						html+='</div>';
					html+='</li>';
      }
      
      // Add image HTML to the page.
      $('#space_list').append(html);
      
      // Apply layout.
      applyLayout();
    };
  
    $(document).ready(new function() {
=======
function clears(){
	page = 1;
	$('#tiles').empty();
	//$('#tiles').masonry('reload');
	$('#tiles').masonry('reloadItems');
	}

var handler = null,
          page = 1,
          _isLoadingMore = false,
          apiURL = 'http://stage.youhuiin.com/front/products/my_favorite_api.json';

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
			loadData(loveType);
          }
        }
      };

      function loadData($loveType) {
        _isLoadingMore = true;
        $('#loaderCircle').show();
		loveType = $loveType;
		//alert(sort);
        $.ajax({
          url: apiURL,
          dataType: 'jsonp',
          data: {page: page,loveType:loveType}, // Page parameter to make sure we load new data
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
		_listpath: 'front/products/list_api.json',
		_container: $('#tiles'),
		_msnry: null,
		_isMsnryInit: false,
		_isLoadingMore: false,
>>>>>>> 我喜欢的宝贝

		onLoad: function(data) {
			var _this = intime.index;
			var length = data.datas.length;
			if (_this._page == 1) {
				if (length <= 0) {
					if (loveType == 1) {
						$('#my_like').show();
						return;
					} else if (loveType == 2) {
						$('#my_like').show();
						return;
					} else if (loveType == 3) {
						$('#my_share').show();
						return;
					}

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
			if (loveType == 1) {
				$(data.datas).each(function() {
					var html = '';
					var one = this;
					html += '<li class="scrollItem">';
					html += '<div class="thumbnail">';
					html += '<div class="action">';
					html += '<a href="product.html"><img src="' + one.imageUrl + '" alt="' + one.imageUrl + '"></a>';
					html += '<span class="like"><i class="icon-heart icon-white"></i>' + one.likeCount + '+</span>';
					html += '</div>';
					html += '<h4><a href="product.html">' + one.title + '</a></h4>';
					html += '<small><span class="pull-left num">吊牌价：<em>￥' + one.originalPrice + '</em></span><span class="pull-right price">销售价：<em>￥' + one.price + '</em></span></small>';
					html += '</div>';
					html += '</li>';
					var elem = $(html).get(0);
					fragment.appendChild(elem);
					elems.push(elem);
				});
			} else if (loveType == 2) {
				$(data.datas).each(function() {
					var html = '';
					var one = this;
					html += '<li class="scrollItem">';
					html += '<div class="thumbnail">';
					html += '<div class="action"> <a href="promo.html" title="' + one.title + '"><img src="' + one.imageUrl + '" alt="' + one.title + '"></a> </div>';
					html += '</div>';
					html += '</li>';
					var elem = $(html).get(0);
					fragment.appendChild(elem);
					elems.push(elem);
				});
			} else if (loveType == 3) {
				$(data.datas).each(function() {
					var html = '';
					var one = this;
					html += '<li class="scrollItem">';
					html += '<div class="thumbnail">';
					html += '<div class="action">';
					html += '<a href="product.html"><img src="' + one.imageUrl + '" alt="' + one.imageUrl + '"></a>';
					html += '<span class="like"><i class="icon-heart icon-white"></i>' + one.likeCount + '+</span>';
					html += '</div>';
					html += '<h4><a href="product.html">' + one.title + '</a></h4>';
					html += '<small><span class="pull-left num">吊牌价：<em>￥' + one.originalPrice + '</em></span><span class="pull-right price">销售价：<em>￥' + one.price + '</em></span></small>';
					html += '</div>';
					html += '</li>';
					var elem = $(html).get(0);
					fragment.appendChild(elem);
					elems.push(elem);
				});
			};
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
		loadData: function($loveType) {
			this._isLoadingMore = true;
			$('#loader').show();
			$('#my_like,#my_share,#last_page').hide();
			var _this = this;
			loveType = $loveType;
			$.ajax({
				url: this.listUrl(),
				dataType: 'jsonp',
				data: {
					page: this._page,
					loveType: loveType
				},
				success: this.onLoad
			}).always(function() {
				_this._isLoadingMore = false;
				$('#loader').hide();
			});

<<<<<<< HEAD
				scrollContainer.append(fragment);
				msnry.appended(elems);
      };
	   
       $(document).ready(new function() {
>>>>>>> 我的银泰
      // Capture scroll event.
      $(document).bind('scroll', onScroll);

      // Load first data from the API.
<<<<<<< HEAD
      loadData('1');
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD

    });

=======
    });
>>>>>>> 我的银泰页面完成
=======
    });
>>>>>>> update js and css
=======
    });
>>>>>>> 他的页面
=======
      loadData('2');
									  });
>>>>>>> 我的银泰
=======
		},
		clears: function() {

			this._page = 1;
			$('#my_share,#my_like,#last_page').hide();
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
					_this.loadData(loveType);
				}
			}
		},
		listUrl: function() {
			return intime.env.host + this._listpath;
		}
	}
<<<<<<< HEAD
});
>>>>>>> 我喜欢的宝贝
=======
});
>>>>>>> update blank prompt
