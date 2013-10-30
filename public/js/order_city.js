   function empty_f(){
	   $("#city").empty();
	   $("#county").empty();
	    $("#county").append("<option>请选择城市</option>");
	    $("#city").append("<option>请选择城市</option>");
	   }
	function empty_h(){
		 $("#county").empty();
		  $("#county").append("<option>请选择城市</option>");
		}
   function city(){
	             $.ajax({
						 url:'select.php',
						 dataType:'json',
						 async:true,
						 success:function(data){
							 mm = data.datas;
							var i=0,length = data.datas.length;
							 for(; i<length; i++) {
									 $("#province").append("<option value='"+data.datas[i].provinceid+"'>"+data.datas[i].provincename+"</option>");
									 }
						}
					});
	   }
  function province_change(b) {
	        var i=0,length = mm.length,b=b;
			for(; i<length; i++) {
									if(b == mm[i].provinceid) {
										 var ci = mm[i].items;
										 var j =0,length =ci.length;
										 for(; j<length; j++) {
											 //alert(mm[i].items[j].cityname);
											 $("#city").append("<option value='"+mm[i].items[j].cityid+"'>"+mm[i].items[j].cityname+"</option>");
											 }
										 
										}
						  }
	}
  
   function cis(c){
	   var i=0,length = mm.length,c=c;
			for(; i<length; i++) {							
										 var j= 0,leng =  mm[i].items.length;
										 for(; j<leng; j++){
											 if(mm[i].items[j].cityid==c){
												 var q=0,leg=mm[i].items[j].items.length;
												  for(;q<leg;q++){
													  //alert(mm[i].items[j].items[q].districtname);
													  $("#county").append("<option value='"+mm[i].items[j].items[q].districtid+"'>"+mm[i].items[j].items[q].districtname+"</option>");
													  }
												 }
											 }
						  }
	   }
  
  $(document).ready(function(){
				           city();
});