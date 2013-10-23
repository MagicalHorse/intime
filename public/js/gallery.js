function clears(){
			   $('#tiles').empty();
			   page=1;
			   }
      var handler = null,
          page = 1,
          isLoading = false,
          apiURL = 'http://www.intime.com.cn:3001/front/products/list_api.json';

      // Prepare layout options.
      var options = {
        autoResize: true, // This will auto-update the layout when the browser window is resized.
        container: $('#tiles'), // Optional, used for some extra CSS styling
        offset: 5, // Optional, the distance between grid items
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
        $.ajax({
          url: apiURL,
          dataType: 'jsonp',
          data: {page: page,type:type,entity_id:entity_id}, // Page parameter to make sure we load new data
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
        var html = '';
        var i=0, length=data.datas.length;
        for(; i<length; i++) {
        html+='<li>';
						html+='<div class="thumbnail">';
							html+='<div class="action">';
								html+='<!--优惠-->';
								html+='<span class="discount">优惠</span>';
								html+='<span class="triangle"></span>';
								html+='<!--优惠-->';
								html+='<a href="product.html"><img src="temp/440_350_1.jpg" alt="开衫连帽卫衣 ASDF335 -2 黛紫色"></a>';
								html+='<span class="like"><i class="icon-heart icon-white"></i>999+</span>';
							html+='</div>';
							html+='<h4><a href="product.html" title="">开衫连帽卫衣 ASDF335 -2 黛紫色</a></h4>';
							html+='<small><span class="pull-left num">吊牌价：<em>￥366</em></span><span class="pull-right price">销售价：<em>￥299</em></span></small>';
						html+='</div>';
					html+='</li>';
        }

        // Add image HTML to the page.
        $('#tiles').append(html);

        // Apply layout.
        applyLayout();
      };
     
      // Capture scroll event.
      $(document).bind('scroll', onScroll);

      // Load first data from the API.
      loadData('1','2');
    
