var handler = null;
    var page = 1;
    var isLoading = false;
    var apiURL = 'http://stage.youhuiin.com/promotions/get_list.json'
    
    // Prepare layout options.
    var options = {
      autoResize: true, // This will auto-update the layout when the browser window is resized.
      container: $('#div'), // Optional, used for some extra CSS styling
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
      page++;
      var length = data.datas.length;
	  var i = 0;
	  var html = '';
	  for(; i<length; i++) {
		 // alert(data.datas[i].storeName);
		//  alert(data.datas[i].storeId);
		   html+='<li>';
						html+='<div class="thumbnail">';
							html+='<div class="location"><i class="icon-map-marker"></i><strong>'+data.datas[i].storeName+'zxfb</strong>（约1121公里）</div>';
							html+='<div class="action">'+'<a href="#">'+'<img src="'+data.datas[i].imageUrl+'" alt=" ">'+'</a>';
								html+='<p>'+data.datas[i].description+'</p>';
							html+='</div>';
							html+='<h3><a href="#" title="">四月会员日活动</a></h3>';
							html+='<small> <span class="pull-left"><i class="icon-time"></i>'+data.datas[i].startDate+'-'+data.datas[i].endDate+'</span> <span class="pull-right"><i class="icon-heart"></i>'+data.datas[i].likeCount+'+</span> </small> </div>';
					html+='</li>';
		    
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
       loadData('1');
	  
    });
