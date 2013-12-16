<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> update js and css
var handler = null;
    var page = 1;
    var isLoading = false;
    var apiURL = 'http://stage.youhuiin.com/front/products/my_favorite_api.json'
    
    
    // Prepare layout options.
    var options = {
      autoResize: true, // This will auto-update the layout when the browser window is resized.
      container: $('#tiles'), // Optional, used for some extra CSS styling
      offset: 2, // Optional, the distance between grid items
      itemWidth: 210 // Optional, the width of a grid item
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
=======
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
			loadData();
          }
>>>>>>> 我的银泰
        }
      };

      function loadData($sort) {
        _isLoadingMore = true;
        $('#loaderCircle').show();
		sort = $sort;
		//alert(sort);
        $.ajax({
          url: apiURL,
          dataType: 'jsonp',
          data: {page: page}, // Page parameter to make sure we load new data
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
			   html+='<li class="scrollItem">';
						 html+='<div class="thumbnail">';
							 html+='<div class="action"> <a href="'+data.datas[i].url+'" title="'+data.datas[i].title+'"><img src="'+data.datas[i].imageUrl+'" alt="'+data.datas[i].title+'"></a> </div>';
						 html+='</div>';
					 html+='</li>';
				var elem = $(html).get(0);
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
<<<<<<< HEAD
      loadData('2');
<<<<<<< HEAD
<<<<<<< HEAD
    });
=======
var handler = null;
    var page = 1;
    var isLoading = false;
    var apiURL = ' http://stage.youhuiin.com/front/products/my_favorite_api.json'
    //var apiURL = ' http://www.intime.com.cn:3000/front/products/my_favorite_api.json'
    
    // Prepare layout options.
    var options = {
      autoResize: true, // This will auto-update the layout when the browser window is resized.
      container: $('#tiles'), // Optional, used for some extra CSS styling
      offset: 2, // Optional, the distance between grid items
      itemWidth: 210 // Optional, the width of a grid item
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
	  loveType = $type;
      $('#loaderCircle').show();
      
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
							 html+='<div class="action"> <a href="promo.html" title="'+data.datas[i].title+'"><img src="'+data.datas[i].imageUrl+'" alt="'+data.datas[i].title+'"></a> </div>';
						 html+='</div>';
					 html+='</li>';
      }
      
      // Add image HTML to the page.
      $('#sp_list').append(html);
      
      // Apply layout.
      applyLayout();
    };
  
    $(document).ready(new function() {
      // Capture scroll event.
      $(document).bind('scroll', onScroll);
      
      // Load first data from the API.
      loadData('2');
    });
>>>>>>> 我的银泰页面完成
=======
    });
>>>>>>> update js and css
=======
    });
>>>>>>> 他的页面
=======
      loadData();
									  });













//var handler = null;
//    var page = 1;
//    var isLoading = false;
//    var apiURL = 'http://stage.youhuiin.com/profile/get_list.json'
//    
//    // Prepare layout options.
//    var options = {
//      autoResize: true, // This will auto-update the layout when the browser window is resized.
//      container: $('#tiles'), // Optional, used for some extra CSS styling
//      offset: 2, // Optional, the distance between grid items
//      itemWidth: 210 // Optional, the width of a grid item
//    };
//    
//    /**
//     * When scrolled all the way to the bottom, add more tiles.
//     */
//    function onScroll(event) {
//      // Only check when we're not still waiting for data.
//      if(!isLoading) {
//        // Check if we're within 100 pixels of the bottom edge of the broser window.
//        var closeToBottom = ($(window).scrollTop() + $(window).height() > $(document).height() - 100);
//        if(closeToBottom) {
//          loadData(loveType);
//        }
//      }
//    };
//    
//    /**
//     * Refreshes the layout.
//     */
//    function applyLayout() {
//      // Clear our previous layout handler.
//      if(handler) handler.wookmarkClear();
//      
//      // Create a new layout handler.
//      handler = $('#tiles li');
//      handler.wookmark(options);
//    };
//    
//    /**
//     * Loads data from the API.
//     */
//    function loadData($type) {
//      isLoading = true;
//	  loveType = $type;
//      $('#loaderCircle').show();
//      
//      $.ajax({
//        url: apiURL,
//        dataType: 'jsonp',
//        data: {page: page,loveType:loveType}, // Page parameter to make sure we load new data
//        success: onLoadData
//      });
//    };
//    
//    /**
//     * Receives data from the API, creates HTML for images and updates the layout
//     */
//    function onLoadData(data) {
//      isLoading = false;
//      $('#loaderCircle').hide();
//      
//      // Increment page index for future calls.
//      page++;
//      
//      // Create HTML for the images.
//      var html = '';
//      var i=0, length=data.datas.length;
//      for(; i<length; i++) {
//         html+='<li>';
//						 html+='<div class="thumbnail">';
//							 html+='<div class="action"> <a href="promo.html" title="'+data.datas[i].title+'"><img src="'+data.datas[i].imageUrl+'" alt="'+data.datas[i].title+'"></a> </div>';
//						 html+='</div>';
//					 html+='</li>';
//      }
//      
//      // Add image HTML to the page.
//      $('#sp_list').append(html);
//      
//      // Apply layout.
//      applyLayout();
//    };
//  
//    $(document).ready(new function() {
//      // Capture scroll event.
//      $(document).bind('scroll', onScroll);
//      
//      // Load first data from the API.
//      loadData('2');
//    });
>>>>>>> 我的银泰
