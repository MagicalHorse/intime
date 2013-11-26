window.intime = window.intime || {};
intime = window.intime;
$.extend(intime, {
	storepromotion: {
		_page: 1,
		_sort: '',
		_listpath: 'front/promotions/get_list.json',
		_container: $('#tiles'),
		_msnry: null,
		_isMsnryInit: false,
		_isLoadingMore: false,
		_canLoadMOre: false,

		onLoad: function(data) {
			var _this = intime.storepromotion;
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
				html += '<h3><i class="icon_title"></i><a href="' + one.url + '" title="">' + one.title + '</a></h3>';
				html += '<div class="action"> <a href="' + one.url + '"><img src="' + one.imageUrl + '" alt=" "></a>';
				html += '<p>'+one.title+'</p>';
				html += '</div>';
				html += '<h3 class="time bottom">活动时间：<span>' + one.startDate + '-' + one.endDate + '</span></h3>';
				html += '<small> <span class="pull-left"><a href="'+ one.storeUrl +'"><i class="icon-map-marker"></i>' + one.storeName + '</a></span> <span class="pull-right"><i class="icon-heart"></i>' + one.likeCount + '+</span> </small> </div>';
				html += '</li>';
				var elem = $(html).get(0);
				fragment.appendChild(elem);
				elems.push(elem);
			});
			_this._container.append(fragment);
			_this._container.imagesLoaded(function() {
				if (!_this._isMsnryInit) {
					_this._isMsnryInit = true;
					_this._container.masonry({
						itemSelector: '.scrollItem'
					});
					_this._msnry = _this._container.data('masonry');
				} else {
					_this._msnry.appended(elems);
				}
			});
		},
		loadData: function($type, $entity_id) {
			this._isLoadingMore = true;
			$('#loader').show();
			$('#no_data,#last_page').hide();
			var _this = this;
			$.ajax({
				url: this.listUrl(),
				dataType: 'jsonp',
				data: {
					page: this._page,
          sort: 1,
					type: $type,
					entity_id: $entity_id
				},
				success: this.onLoad
			}).always(function() {
				_this._isLoadingMore = false;
				$('#loader').hide();
			});

		},
		clears: function() {
			this._canLoadMore = false;
			this._isLoadingMore = false;
			this._page = 1;
			this._container.empty();
			if (this._msnry) {
				var items = this._msnry.getItemElements();
				if (items && items.length>0) {
					this._msnry.remove(items);	
					this._isMsnryInit= false;
					this._msnry.destroy();
				}
			}
		},
		onScroll: function(event) {
			// Only check when we're not still waiting for data.
			var _this = intime.storepromotion;
			if (_this._canLoadMore && !_this._isLoadingMore) {
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
