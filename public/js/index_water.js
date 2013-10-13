 var handler = null;
    var page = 1;
    var isLoading = false;
    var apiURL = 'http://www.wookmark.com/api/json/popular'
    
    var options = {
      autoResize: true, // This will auto-update the layout when the browser window is resized.
      container: $('#tiles'), // Optional, used for some extra CSS styling
      offset: 2, // Optional, the distance between grid items
      itemWidth: 210 // Optional, the width of a grid item
    };
    
    function onScroll(event) {
      if(!isLoading) {
        var closeToBottom = ($(window).scrollTop() + $(window).height() > $(document).height() - 100);
        if(closeToBottom) {
          loadData();
        }
      }
    };
    
    function applyLayout() {
      if(handler) handler.wookmarkClear();
      
      handler = $('#tiles li');
      handler.wookmark(options);
    };
    
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
    
    function onLoadData(data) {
      isLoading = false;
      $('#loaderCircle').hide();
      
      page++;
      
      var html = '';
      var i=0, length=data.length, image;
      for(; i<length; i++) {
        image = data[i];
        html+='<li>';
						html+='<div class="thumbnail">';
							html+='<div class="location"><i class="icon-map-marker"></i><strong>银泰杭州文化广场店</strong>（约1121公里）</div>';
							html+='<div class="action">'+'<a href="#">'+'<img src="temp/280_200_1.jpg" alt=" ">'+'</a>';
								html+='<p>'+'喜欢银泰，乐享三倍积点。银泰年中庆，小积点也能玩出大动作，三倍积点大赠送啦！'+'</p>';
							html+='</div>';
							html+='<h3><a href="#" title="">四月会员日活动</a></h3>';
							html+='<small> <span class="pull-left"><i class="icon-time"></i>2013.06.21-2013.06.21</span> <span class="pull-right"><i class="icon-heart"></i>999+</span> </small> </div>';
					html+='</li>';
      }
      
      $('#tiles').append(html);
      applyLayout();
    };
 $("#recently").click(function(){
 	  $("#recently_div").show();
 		$("#news_div").hide();
 	  $("#future_div").hide();
 	});
 	$("#news").click(function(){
 		$("#recently_div").hide();
 		$("#news_div").show();
 	  $("#future_div").hide();
 	});
 	$("#future").click(function(){
 		 $("#recently_div").hide();
 		$("#news_div").hide();
 	  $("#future_div").show();
 	});
 	 $(document).ready(function(){
 	 	  $(document).bind('scroll', onScroll);
      loadData();
 	 	  $("#news_div").hide();
 	 	  $("#future_div").hide();
 	 	});