      var handler = null,
          page = 1,
          isLoading = false,
          apiURL = 'http://stage.youhuiin.com/front/products/list_api.json';

      // Prepare layout options.
      var options = {
        autoResize: true, // This will auto-update the layout when the browser window is resized.
        container: $('#tiles'), // Optional, used for some extra CSS styling
        offset: 5, // Optional, the distance between grid items
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
            loadData(type,entity_id);
          }
        }
      };

      /**
       * Refreshes the layout.
       */
      function applyLayout() {
        options.container.imagesLoaded(function() {
          // Create a new layout handler when images have loaded.
          handler = $('#tiles li');
          handler.wookmark(options);
        });
      };

      /**
       * Loads data from the API.
       */
      function loadData($type,$entity_id) {
        isLoading = true;
        $('#loaderCircle').show();
        type = $type;
		    entity_id = $entity_id;
		    if(typeof(entity_id)=="undefined"){
		    	   $.ajax({
          url: 'http://stage.youhuiin.com/front/products/search_api.json',
          dataType: 'jsonp',
          data: {page: page,term:type}, // Page parameter to make sure we load new data
          success: onLoadData
        });
		    	} else {
		    		 $.ajax({
          url: apiURL,
          dataType: 'jsonp',
          data: {page: page,type:type,entity_id:entity_id}, // Page parameter to make sure we load new data
          success: onLoadData
        });
		    		}
        
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
        var html = '';
        var i=0, length=data.datas.length;
        for(; i<length; i++) {
			//alert(data.datas[i].imageUrl);
           html+='<li>';
						html+='<div class="thumbnail">';
							html+='<div class="action">';
								html+='<!--优惠-->';
								html+='<span class="discount">优惠</span>';
								html+='<span class="triangle"></span>';
								html+='<!--优惠-->';
								html+='<a href="'+data.datas[i].url+'"><img src="'+data.datas[i].imageUrl+'" alt="'+data.datas[i].title+'"></a>';
								html+='<span class="like"><i class="icon-heart icon-white"></i>'+data.datas[i].likeCount+'+</span>';
							html+='</div>';
							html+='<h4><a href="'+data.datas[i].url+'" title="">'+data.datas[i].title+'</a></h4>';
							html+='<small><span class="pull-left num">吊牌价：<em>￥'+data.datas[i].originalPrice+'</em></span><span class="pull-right price">销售价：<em>￥'+data.datas[i].price+'</em></span></small>';
						html+='</div>';
					html+='</li>';
        }

        // Add image HTML to the page.
        $('#tiles').append(html);

        // Apply layout.
        applyLayout();
      };
	  function clears(){
		  page = 1;
		  $("#tiles").empty();
		  }
    
      // Capture scroll event.
      $(document).bind('scroll', onScroll);

      // Load first data from the API.
      loadData('c','v');
		
