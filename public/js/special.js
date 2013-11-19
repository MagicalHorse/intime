window.intime = window.intime || {};
intime = window.intime;
$.extend(intime, {
	index: {
		_page: 1,
		_sort: '',
		_listpath: 'front/specials/get_list.json',
		_container: $('#tiles'),
		_msnry: null,
		_isMsnryInit: false,
		_isLoadingMore: false,

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
			$(data.datas).each(function() {
				var html = '';
				var one = this;
				html += '<li class="scrollItem">';
				html += '<div class="thumbnail">';
				html += '<div class="action"><a href="' + one.url + '"><img src="' + one.imageUrl + '" alt="' + one.title + '"></a></div>';
				html += '<h3 class="mt6"><i class="icon_title"></i><a href="promo.html" title="">' + one.title + '</a></h3>';
				html += '<div class="summary">' + one.description + '</div>';
				html += '<small> <span class="pull-left"><i class="icon-time"></i>' + one.startDate + '</span> <span class="pull-right"><i class="icon-heart"></i>' + one.likeCount + '+</span> </small> </div>';
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
		loadData: function() {
			this._isLoadingMore = true;
			$('#loader').show();
			$('#no_data,#last_page').hide();
			var _this = this;
			$.ajax({
				url: this.listUrl(),
				dataType: 'jsonp',
				data: {
					page: this._page
				},
				success: this.onLoad
			}).always(function() {
				_this._isLoadingMore = false;
				$('#loader').hide();
			});

		},
		clears: function() {

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
					_this.loadData();
				}
			}
		},
		listUrl: function() {
			return intime.env.host + this._listpath;
		}
	}
});