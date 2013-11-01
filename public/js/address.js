function address(){
	             $.ajax({
						 //type:"get",
						 url:'http://stage.youhuiin.com/front/addresses.json',
						 //data:{'id':id},
						 dataType:'jsonp',
						 async:true,
						 success:function(data){
							 address = data.datas;
							var i=0,length = data.datas.length;
							var html="";
							for(; i<length; i++) {
								html+="<label style='padding:0'>";
													html+="<div class='item'>";
														html+="<div class='item_tit thzq lh25'>";
														html+="<input  type='radio'  name='RadioGroup1' value='"+data.datas[i].id+"' id='RadioGroup1_1'>";
															html+="<span>收货人：</span><span id='consignee_name'>"+data.datas[i].shippingperson+"</span><br>";
															html+="<span>手机号码：</span><span id='consignee_phone'>"+data.datas[i].shippingphone+"</span><br>";
															html+="<span>省份：</span>"+data.datas[i].shippingprovince+"-"+data.datas[i].shippingcity+"-"+data.datas[i].shippingdistrict+"<br>";
															html+="<span>收货地址：</span>"+data.datas[i].displayaddress+"<br>";
															html+="<span>邮编：</span>"+data.datas[i].shippingzipcode+"<br>";
														html+="</div>";
													html+="</div>";
												html+="</label>";
												
								}
								$("#address").append(html);
							}
					});
	   }
   
  function change(){
	 var addressid = $("input[name='RadioGroup1']:checked").val();
	 var i=0,length = address.length;
	 for(; i<length; i++) {
		 if(address[i].id ==addressid){
			 $('#shippingperson').html(address[i].shippingperson);
									 $('#shippingprovince').html(address[i].shippingprovince+" "+address[i].shippingcity+" "+address[i].shippingdistrict); 
						       $('#displayaddress').html(address[i].displayaddress); 
						       $('#shippingzipcode').html(address[i].shippingzipcode); 
						       $('#shippingphone').html(address[i].shippingphone); 
			 }
		 }
	// alert(address);
	  }
  $(document).ready(function(){
  	               
				           address();
				          
							 });