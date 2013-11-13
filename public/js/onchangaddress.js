//	
<!--回填修改数据的信息-->
//function address_huiitanxiu(){
//
//
//	var shippingperson=$("#shippingperson").val();
//	$("#address_shippingperson").val()=shippingperson;
//	
//	var shippingphone=$("#shippingphone").val();
//	$("#address_shippingphone").val=shippingphone;
//	
//	var displayaddress=$("#displayaddress").val();
//	$("$address_shippingaddress").val()=displayaddress;
//	
//	var shippingzipcode=$("#shippingzipcode").val();
//	$("#address_shippingzipcode").val()=shippingzipcode;
//	
//	}

/*<!-- //添加地址：地址改变联动，选择下一级-->
   function address_sheng(){
	   $('select[data-name=city_id]').empty();
	  $('select[data-name=district_id]').empty();
	 
	    $('select[data-name=city_id]').append("<option>请选择城市</option>");
	    $('select[data-name=district_id]').append("<option>请选择市区</option>");
	   }
	function address_shi(){
		 $('select[data-name=district_id]').empty();
		   $('select[data-name=district_id]').append("<option>请选择市区</option>");
		}
				
 
 
<!-- //添加地址数据-->*/
 
<!-- //添加地址：地址改变联动，选择下一级 下一步进行点击确认按钮到达回填选项-->
   function load_city(){
	     
	             $.ajax({
					  //  type:"get",
						 url:'http://stage.youhuiin.com/front/supportshipments.json',
						 dataType:'jsonp',
						 async:true,
						 success:function(data){
							 
							
							 mm = data.datas;
							var i=0,length = data.datas.length;
							
						$('select[data-name=province_id]').append("<option>请选择省市</option>");
						  $('select[data-name=city_id]').append("<option>请选择城市</option>");
	    $('select[data-name=district_id]').append("<option>请选择市区</option>");
							 for(; i<length; i++) {
								
									 $('select[data-name=province_id]').append("<option value='"+data.datas[i].provinceid+"'>"+data.datas[i].provincename+"</option>");
									 
									 
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
											$('select[data-name=city_id]').append("<option value='"+mm[i].items[j].cityid+"'>"+mm[i].items[j].cityname+"</option>");
											 }
										 
										}
						  }
	}
  
   function shi_change(c){
	   
	
	   var i=0,length = mm.length,c=c;
			for(; i<length; i++) {							
										 var j= 0,leng =  mm[i].items.length;
										 for(; j<leng; j++){
											 if(mm[i].items[j].cityid==c){
												 var q=0,leg=mm[i].items[j].items.length;
												  for(;q<leg;q++){
													 $('select[data-name=district_id]').append("<option value='"+mm[i].items[j].items[q].districtid+"'>"+mm[i].items[j].items[q].districtname+"</option>");
													  }
												 }
											 }
						  }
	   }
  
  $(document).ready(function(){
				           load_city();
						   
					
		 $('select[data-name=province_id]').change(function(){
		
	    $('select[data-name=city_id]').empty(); 
	    $('select[data-name=city_id]').append("<option>请选择城市</option>");
		$('select[data-name=district_id]').empty();
	    $('select[data-name=district_id]').append("<option>请选择市区</option>");
	   
	  
	  
	   sheng_change($(this).val());
	   
	   });
	   
	   
	$('select[data-name=city_id]').change(function(){  
	 
	       $('select[data-name=district_id]').empty();
		   $('select[data-name=district_id]').append("<option>请选择市区</option>");
	   
	 
	      shi_change($(this).val());
	 
	  });
	  
	  
	  
});

