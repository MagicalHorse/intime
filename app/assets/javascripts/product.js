window.intime = window.intime || {};
intime = window.intime;
$.extend(intime, {
	product: {		
		_page: 1,
		_sort: '',
		_listpath: 'front/comments/get_list.json',
		_container: $('#tiles'),
		_msnry: null,
		_isMsnryInit: true,
		_isLoadingMore: false,
		_gtTarget:'',
		_ltTarget:'',
		_supportTouch:'ontouchstart' in window,
		init:function(gtTarget,ltTarget){
			$(document).bind('scroll', this.onScroll);
			this._showSlide(false);
			var _this = this;
			this._gtTarget = gtTarget;
			this._ltTarget = ltTarget;
			$("#picbox,#toTop").addClass("noSwipe");
			var swipeHandler = {allowPageScroll:"vertical"};
			if (this._supportTouch){
				$.extend(swipeHandler,{
					swipeStatus:function(event,phase,direction,distance, duration, fingerCount ){
						if (phase == 'start'){
							_this._showSlide(true);
						} else if(phase == 'end' || phase =='cancel'){
							_this._showSlide(false);
						}
						return true;
					}
				});
			
				if (this._gtTarget!=''){
					$.extend(swipeHandler,{
						swipeLeft:function(event, direction, distance, duration, fingerCount) {
								document.location.href = _this._gtTarget;
							}
					});
				}
				if (this._ltTarget!=''){
					$.extend(swipeHandler,{
						swipeRight:function(event, direction, distance, duration, fingerCount) {
								document.location.href = _this._ltTarget;
						}
					});
				}
				$("body").swipe(swipeHandler);
			}
			return this;
		},
		
		onLoad: function(data) {
			
			var _this = intime.product;
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
        if(one.replyUser) {
          html += '<br>回复&nbsp;' + one.replyUser + '</p>';
        }
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
			this._canLoadMore = false;
			this._isLoadingMore = false;
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
			
			var _this = intime.product;
			if (_this._canLoadMore && !_this._isLoadingMore) {
				// Check if we're within 100 pixels of the bottom edge of the broser window.
				var closeToBottom = ($(window).scrollTop() + $(window).height() > $(document).height() - 100);
			
				if (closeToBottom) {
					_this.loadData(sourceid,sourcetype);
				}
			}
		},
		listUrl: function() {
			return intime.env.host + this._listpath;
		},
		_showSlide: function(flag){
			if (flag == false){
				$(".pro_prev,.pro_next").hide();
			} else {
				if (this._gtTarget != '')
					$(".pro_next").show();
				if (this._ltTarget !='')
					$(".pro_prev").show();
			}
			
		}
	}
});
