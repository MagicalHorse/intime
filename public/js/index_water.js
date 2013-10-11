var handler = null;
    var page = 1;
    var isLoading = false;
    var apiURL = 'http://stage.youhuiin.com/promotions/get_list.json'
    
    // Prepare layout options.
    var options = {
      autoResize: true, // This will auto-update the layout when the browser window is resized.
      container: $('#tiles'), // Optional, used for some extra CSS styling
      offset: 2, // Optional, the distance between grid items
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
          loadData(sort);
        }
      }
    };
     function onLoadData(data) {
      isLoading = false;
      $('#loaderCircle').hide();
      var length = data.datas.length;
	  //alert(length);
	  var i = 0;
	  var html = '';
	  for(; i<length; i++) {
		 // alert(data.datas[i].storeName);
		//  alert(data.datas[i].storeId);
		  //////////////////////////////////////////////////////////////
		    html+='<div class="page-header">';
						html+='<h2><a href="shop.html"><i class="icon_location"></i>'+data.datas[i].storeId+'<span class="distance">（约1121公里）</span></a></h2>';
					html+='</div>';
					html+='<ul id="tiles" class="thumbnails">';
		   
		  //////////////////////////////////////////////////////////////
		    var leng = data.datas[i].promotions.length;
			var j = 0;
			for(;j<leng;j++){
				   html+='<li>';
							 html+='<div class="thumbnail">';
								 html+='<div class="action"> <a href="#"><img src="temp/280_200_1.jpg" alt=" "></a>';
									 html+='<p>喜欢银泰，乐享三倍积点。银泰年中庆，小积点也能玩出大动作，三倍积点大赠送啦！</p>';
								 html+='</div>';
								 html+='<h3><i class="icon_title"></i><a href="#" title="">'+data.datas[i].promotions[j].endDate+'</a></h3>';
								 html+='<small> <span class="pull-left"><i class="icon-time"></i>2013.06.21-2013.06.21</span> <span class="pull-right"><i class="icon-heart"></i>999+</span> </small> </div>';
						 html+='</li>';
				}
			html+='</ul>';
		  }
		  $('#div').append(html);
      applyLayout();
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
    function loadData($sort) {
      $('#loaderCircle').show();
      //alert(page);
      //alert(type);
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
    
    
    $(document).ready(new function() {
      // Capture scroll event.
      $(document).bind('scroll', onScroll);
      
      // Load first data from the API.
       loadData('3');
	  
    });
