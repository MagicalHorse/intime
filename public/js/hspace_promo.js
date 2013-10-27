var handler = null;
    var page = 1;
    var isLoading = false;
    var apiURL = 'http://stage.youhuiin.com/front/products/his_favorite_api.json'
    
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
      if(length == 0){
      	html='<p style='text-align:center;font-size: 16px;line-height:30px;'>好多精彩超值的促销活动千万不要错过!<br>共收藏0个活动!<br><a href='index.html' class='btn btn-danger '>去看看促销</a></p>';
      	} else {
      		 for(; i<length; i++) {
         html+='<li>';
						 html+='<div class="thumbnail">';
							 html+='<div class="action"> <a href="'+data.datas[i].url+'" title="'+data.datas[i].title+'"><img src="'+data.datas[i].imageUrl+'" alt="'+data.datas[i].title+'"></a> </div>';
						 html+='</div>';
					 html+='</li>';
      }
      		}
      // Add image HTML to the page.
      
      $('#tiles').append(html);
      
      // Apply layout.
      applyLayout();
    };
  
    $(document).ready(new function() {
      // Capture scroll event.
      $(document).bind('scroll', onScroll);
      
      // Load first data from the API.
      loadData('2');
    });
