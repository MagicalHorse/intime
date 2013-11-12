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
        $('#loader').show();
		sort = $sort;
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
        $('#loader').hide();

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
				  //alert(data.datas[i].title);
			   html+='<li class="scrollItem">';
							html+='<div class="thumbnail">';
								html+='<h3><i class="icon_title"></i><a href="'+data.datas[i].url+'" title="">'+data.datas[i].title+'</a></h3>';
								html+='<div class="action"> <a href="'+data.datas[i].url+'"><img src="'+data.datas[i].imageUrl+'" alt=" "></a>';
									html+='<p>'+data.datas[i].description+'</p>';
								html+='</div>';
								html+='<h3 class="time bottom">活动时间：<span>'+data.datas[i].startDate+'-'+data.datas[i].endDate+'</span></h3>';
								html+='<small> <span class="pull-left"><a href="'+data.datas[i].storeUrl+'"><i class="icon-map-marker"></i>'+data.datas[i].storeName+'</a></span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
						html+='</li>';
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
       loadData('1');
									  });
