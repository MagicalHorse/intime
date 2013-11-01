   function empty_sheng(){
	   $("#cheng").empty();
	   $("#qu").empty();
	    $("#cheng").append("<option>请选择城市</option>");
	    $("#qu").append("<option>请选择城市</option>");
	   }
	function empty_cheng(){
		 $("#qu").empty();
		  $("#qu").append("<option>请选择城市</option>");
		}
   function load_city(){
	             $.ajax({
						 url:'http://stage.youhuiin.com/front/supportshipments.json',
						 dataType:'jsonp',
						 async:true,
						 success:function(data){
							 mm = data.datas;
							var i=0,length = data.datas.length;
							 for(; i<length; i++) {
									 $("#sheng").append("<option value='"+data.datas[i].provinceid+"'>"+data.datas[i].provincename+"</option>");
									 }
						}
					});
	   }
  function sheng_change(b) {
	        var i=0,length = mm.length,b=b;
			for(; i<length; i++) {
									if(b == mm[i].provinceid) {
										 var ci = mm[i].items;
										 var j =0,length =ci.length;
										 for(; j<length; j++) {
											 $("#cheng").append("<option value='"+mm[i].items[j].cityid+"'>"+mm[i].items[j].cityname+"</option>");
											 }
										 
										}
						  }
	}
  
   function cheng_change(c){
	   var i=0,length = mm.length,c=c;
			for(; i<length; i++) {							
										 var j= 0,leng =  mm[i].items.length;
										 for(; j<leng; j++){
											 if(mm[i].items[j].cityid==c){
												 var q=0,leg=mm[i].items[j].items.length;
												  for(;q<leg;q++){
													  $("#qu").append("<option value='"+mm[i].items[j].items[q].districtid+"'>"+mm[i].items[j].items[q].districtname+"</option>");
													  }
												 }
											 }
						  }
	   }
  
  $(document).ready(function(){
				           load_city();
});