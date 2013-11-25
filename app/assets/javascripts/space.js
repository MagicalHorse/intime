window.intime = window.intime || {};
intime = window.intime;
$.extend(intime, {
	space: {
		_page: 1,
		_sort: '',
		_listpath: 'front/products/my_favorite_api.json',
		_container: $('#tiles'),
		_msnry: null,
		_isMsnryInit: false,
		_isLoadingMore: false,
		_canLoadMore: false,
		init: function(){
			$(document).bind('scroll', this.onScroll);
			var _this = this;
			$('.nav>li').click(function(){
				$('.nav>li').removeClass('active');
				$(this).addClass('active');
				var sort = $(this).find('a:first').attr('data-spacetype');
				_this.clears();
				_this.loadData(sort);
			});
			$('.nav>li :first').click();
		},
		onLoad: function(data) {
			var _this = intime.space;
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
			if (loveType == 1) {
				$(data.datas).each(function() {
					var html = '';
					var one = this;
					html += '<li class="scrollItem">';
					html += '<div class="thumbnail">';
					html += '<div class="action">';
					html += '<a href="' + one.url + '"><img src="' + one.imageUrl + '" alt="' + one.imageUrl + '"></a>';
					html += '<span class="like"><i class="icon-heart icon-white"></i>' + one.likeCount + '+</span>';
					html += '</div>';
					html += '<h4><a href="' + one.url + '">' + one.title + '</a></h4>';
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
					html += '<div class="action"> <a href="' + one.url + '" title="' + one.title + '"><img src="' + one.imageUrl + '" alt="' + one.title + '"></a> </div>';
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
					html += '<a href="' + one.url + '"><img src="' + one.imageUrl + '" alt="' + one.imageUrl + '"></a>';
					html += '<span class="like"><i class="icon-heart icon-white"></i>' + one.likeCount + '+</span>';
					html += '</div>';
					html += '<h4><a href="' + one.url + '">' + one.title + '</a></h4>';
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

		},
		clears: function() {
			this._isLoadingMore = false;
			this._canLoadMore = false;
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
			var _this = intime.space;
			if (_this._canLoadMore && !_this._isLoadingMore) {
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
});
