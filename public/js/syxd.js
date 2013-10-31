   function empty_shengsyxd(){
	   $("#cheng_syxd").empty();
	   $("#qusyxd").empty();
	    $("#cheng_syxd").append("<option>请选择城市</option>");
	    $("#qusyxd").append("<option>请选择所在区县</option>");
	   }
	function empty_chengsyxd(){
		 $("#qusyxd").empty();
		  $("#qusyxd").append("<option>请选择所在区县</option>");
		}
   function load_syxd(){
	             $.ajax({
						 url:'select.php',
						 dataType:'json',
						 async:true,
						 success:function(data){
							 mm = data.datas;
							var i=0,length = data.datas.length;
							 for(; i<length; i++) {
									 $("#sheng_syxd").append("<option value='"+data.datas[i].provinceid+"'>"+data.datas[i].provincename+"</option>");
									 }
						}
					});
	   }
  function shengsyxd_change(b) {
	        var i=0,length = mm.length,b=b;
			for(; i<length; i++) {
									if(b == mm[i].provinceid) {
										 var ci = mm[i].items;
										 var j =0,length =ci.length;
										 for(; j<length; j++) {
											 //alert(mm[i].items[j].cityname);
											 $("#cheng_syxd").append("<option value='"+mm[i].items[j].cityid+"'>"+mm[i].items[j].cityname+"</option>");
											 }
										 
										}
						  }
	}
  
   function chengsyxd_change(c){
	   var i=0,length = mm.length,c=c;
			for(; i<length; i++) {							
										 var j= 0,leng =  mm[i].items.length;
										 for(; j<leng; j++){
											 if(mm[i].items[j].cityid==c){
												 var q=0,leg=mm[i].items[j].items.length;
												  for(;q<leg;q++){
													  //alert(mm[i].items[j].items[q].districtname);
													  $("#qusyxd").append("<option value='"+mm[i].items[j].items[q].districtid+"'>"+mm[i].items[j].items[q].districtname+"</option>");
													  }
												 }
											 }
						  }
	   }
  
  $(document).ready(function(){
				           load_syxd();
});