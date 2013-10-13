 var handler = null;
    var page = 1;
    var isLoading = false;
    var apiURL = 'http://www.wookmark.com/api/json/popular'
    
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
          loadData();
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
    function loadData() {
      isLoading = true;
      $('#loaderCircle').show();
      
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
      isLoading = false;
      $('#loaderCircle').hide();
      
      // Increment page index for future calls.
      page++;
      
      // Create HTML for the images.
      var html = '';
      var i=0, length=data.length, image;
      for(; i<length; i++) {
        image = data[i];
        html+='<li>';
						html+='<div class="thumbnail">';
							html+='<div class="action"> <a href="promo.html"><img src="temp/280_200_1.jpg" alt="四月会员日活动"></a>';
								html+='<p>喜欢银泰，乐享三倍积点。银泰年中庆，小积点也能玩出大动作，三倍积点大赠送啦！</p>';
							html+='</div>';
							html+='<h3 class="bottom"><i class="icon_title"></i><a href="promo.html" title="">四月会员日活动</a></h3>';
							html+='<small> <span class="pull-left"><i class="icon-time"></i>2013.06.21-2013.06.21</span> <span class="pull-right"><i class="icon-heart"></i>999+</span> </small> </div>';
					html+='</li>';
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
      loadData();
    });