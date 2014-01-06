window.intime = window.intime || {};
intime = window.intime;
$.extend(intime, {
	gallery: {
		_page: 1,
		_sort: '',
		_searchpath: 'front/products/search_api.json',
		_listpath: 'front/products/list_api.json',
		_container: $('#tiles'),
		_msnry: null,
		_isMsnryInit: false,
		_isLoadingMore: false,
		_canLoadMore: false,
		init: function(){
			var _this = this;
			$('#no_data').hide();
			
			$(document).bind('scroll', this.onScroll);

			$('.navbar .nav #menu1 .dropdown-menu,.navbar .nav #menu2 .dropdown-menu').perfectScrollbar({
				wheelSpeed: 30,
				wheelPropagation: false
			});	

			$('#myTab a').click(function (e) {
				e.preventDefault();
				e.stopPropagation();
				$(this).tab('show');
				$("#menu2").removeClass("active");
				$("#myTab a").removeClass("active");
				$(this).addClass("active");
			})
			$(".nav a[role='menuitem']").click(function(){
				$(".nav a[role='menuitem']").removeClass("active");
				$(this).addClass("active");
				var searchKey = $(this).attr('data-gallerykey');
				var searchType = $(this).attr('data-gallerytype');
				_this.clears();
				if (searchKey == undefined) {
					_this.loadData(searchType);
				} else {
					_this.loadData(searchType,searchKey);
				}
				
			});
			
			$("#btnSearch").click(function(){
				var key = $('#search').val();
				if (key.length<=0)
					return;
				_this.clears();
				_this.loadData(key);
			});
			this.loadData('s','c');
		},
		onLoad: function(data) {
			var _this = intime.gallery;
			var length = data.datas.length;
			if (_this._page == 1) {
				if (length <= 0) {
					$('#no_data').show();
					return;
				}

			} 
			if (_this._page<data.totalpaged){
				_this._canLoadMore = true;

			} else {
				_this._canLoadMore = false;
				$('#last_page').show();
			}
			_this._page++;

			var elems = [];
			var fragment = document.createDocumentFragment();
			$(data.datas).each(function() {
				var html = '';
				var one = this;
				html += '<li class="scrollItem">';
				html += '<div class="thumbnail">';
				html += '<div class="action">';
				if (one.flag.toString() == "true") {
					html += '<span class="discount">优惠</span>';
					html += '<span class="triangle"></span>';
				}
				//html += '<a href="' + one.url + '"><img src="' + one.imageUrl + '" alt="' + one.title + '"></a>';
				
				var holder_mock = intime.gallery._format_holder_url(one);
				html += '<a href="' + one.url + '"><img class="lazy" data-src="'+holder_mock +'" origin-src="'+ one.imageUrl + '" alt="' + one.title + '"></a>';
				if (one.is4sale && one.is4sale.toString() =="true") {
					html += '<span class="bag"></span>';
				}
				html += '</div>';
				html += '<h4><a href="'+one.url+'" title="">' + one.title + '</a></h4>';
				html += '<small><span class="pull-left num">吊牌价：<em>￥' + one.originalPrice + '</em></span><span class="pull-right price">销售价：<em>￥' + one.price + '</em></span></small>';
				html += '</div>';
				html += '</li>';
				var elem = $(html).get(0);
				fragment.appendChild(elem);
				elems.push(elem);
			});
			_this._container.append(fragment);		
			Holder.run();	
			if (!_this._isMsnryInit) {
				_this._isMsnryInit = true;
				_this._msnry = new Masonry(_this._container[0], {
					itemSelector: '.scrollItem'
				});
			} else {
				_this._msnry.appended(elems);
			}
			$(elems).each(function() {
				var lazyImage = $(this).find(".lazy");
				var originUrl = lazyImage.attr('origin-src');
				lazyImage.attr('src',originUrl);
				lazyImage.removeAttr('data-src');
			});
		},
		loadData: function($type, $entity_id) {
			this._isLoadingMore = true;
			$('#loader').show();
			$('#no_data,#last_page').hide();
			var _this = this;
			type = $type;
			entity_id = $entity_id;
			if ($entity_id) {
				$.ajax({
					url: this.listUrl(),
					dataType: 'jsonp',
					data: {
						page: this._page,
						type: $type,
						entity_id: $entity_id
					},
					success: this.onLoad
				}).always(function() {
					_this._isLoadingMore = false;
					$('#loader').hide();
				});

			} else {
				$.ajax({
					url: this.searchUrl(),
					dataType: 'jsonp',
					data: {
						page: this._page,
						term: $type
					},
					success: this.onLoad
				}).always(function() {
					_this._isLoadingMore = false;
					$('#loader').hide();
				});
			}

		},
		clears: function() {

			this._page = 1;
			this._isLoadingMore = false;
			this._canLoadMore = false;
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
			var _this = intime.gallery;
			if (_this._canLoadMore && !_this._isLoadingMore) {
				// Check if we're within 100 pixels of the bottom edge of the broser window.
				var closeToBottom = ($(window).scrollTop() + $(window).height() > $(document).height() - 100);
				if (closeToBottom) {
					_this.loadData(type, entity_id);
				}
			}
		},
		searchUrl: function() {
			return intime.env.host + this._searchpath;
		},
		listUrl: function() {
			return intime.env.host + this._listpath;
		},
		_format_holder_url :function(product){
			var mock_width = 320;
			var mock_height = parseInt(product.imageOriginHeight/product.imageOriginWidth * mock_width);
			return 'holder.js/'+mock_width.toString()+'x'+mock_height.toString();
		}
	}
});
