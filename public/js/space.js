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
				return;
				//alert(length);
			var elems = [];
			var fragment = document.createDocumentFragment();


			  for ( ; i < length; i++ ) {
				if(loveType==1){
							html+='<li class="scrollItem">';
										html+='<div class="thumbnail">';
											html+='<div class="action">';
												html+='<a href="'+data.datas[i].url+'"><img src="'+data.datas[i].imageUrl+'" alt="'+data.datas[i].imageUrl+'"></a>';
												html+='<span class="like"><i class="icon-heart icon-white"></i>'+data.datas[i].likeCount+'+</span>';
											html+='</div>';
											html+='<h4><a href="'+data.datas[i].url+'">'+data.datas[i].title+'</a></h4>';
											html+='<small><span class="pull-left num">吊牌价：<em>￥'+data.datas[i].originalPrice+'</em></span><span class="pull-right price">销售价：<em>￥'+data.datas[i].price+'</em></span></small>';
										html+='</div>';
									html+='</li>';
						}else if(loveType==2) {
							html+='<li class="scrollItem">';
										 html+='<div class="thumbnail">';
											 html+='<div class="action"> <a href="'+data.datas[i].url+'" title="'+data.datas[i].title+'"><img src="'+data.datas[i].imageUrl+'" alt="'+data.datas[i].title+'"></a> </div>';
										 html+='</div>';
									 html+='</li>';
						} else if(loveType==3) {
							html+='<li class="scrollItem">';
										html+='<div class="thumbnail">';
											html+='<div class="action">';
												html+='<a href="'+data.datas[i].url+'"><img src="'+data.datas[i].imageUrl+'" alt="'+data.datas[i].imageUrl+'"></a>';
												html+='<span class="like"><i class="icon-heart icon-white"></i>'+data.datas[i].likeCount+'+</span>';
											html+='</div>';
											html+='<h4><a href="'+data.datas[i].url+'">'+data.datas[i].title+'</a></h4>';
											html+='<small><span class="pull-left num">吊牌价：<em>￥'+data.datas[i].originalPrice+'</em></span><span class="pull-right price">销售价：<em>￥'+data.datas[i].price+'</em></span></small>';
										html+='</div>';
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
      loadData('2');
									  });
