
<!--//第一次加载所有的地址，可选择-->
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
	 var i=1,length = address.length;
	
	

	 for(; i<length; i++) {
		
	
		 if(address[i].id == addressid){
			 
			
			                   $('#shippingperson').html(address[i].shippingperson);
							   $('#shippingprovince').html(address[i].shippingprovince+" "+address[i].shippingcity+" "+address[i].shippingdistrict); 
						       $('#shippingaddress').html(address[i].shippingaddress); 
						       $('#shippingzipcode').html(address[i].shippingzipcode); 
						       $('#shippingphone').html(address[i].shippingphone); 
							  
							 
							 //再次更新表单添加到隐藏的列表中
							 $("#edit_user").val(address[i].shippingperson);
                          
							 if(address[i].shippingprovince==$("#sheng").find("option").eq(i).attr("value")){
								
								   $("#sheng").find("option").eq(i).attr("value");
								   $("#cheng").find("option").eq(i).attr("value");
								   $("#qu").find("option").eq(i).attr("value");
								
								 }else{
									 
							    $("#sheng").append("<option value='"+address[i].shippingprovinceid+"'>"+address[i].shippingprovince+"</option>");
								$("#sheng option[value='"+address[i].shippingprovinceid+"']").attr("selected", "selected");
                                $("#cheng").append("<option value='"+address[i].shippingcityid+"'>"+address[i].shippingcity+"</option>");
						        $("#cheng option[value='"+address[i].shippingcityid+"']").attr("selected", "selected");
						        $("#qu").append("<option value='"+address[i].shippingdistrictid+"'>"+address[i].shippingdistrict+"</option>");
						        $("#qu option[value='"+address[i].shippingdistrictid+"']").attr("selected", "selected");
		   
		   
		   
									  $("#edit_address").val(address[i].shippingaddress);
									  $("#edit_code").val(address[i].shippingzipcode);
									  $("#edit_phone").val(address[i].shippingphone);
		  
		  
		  $("#sheng option").each(function () {
											var text = $(this).text();
											if ($("#sheng option:contains('" + text + "')").length > 1)
												$("#sheng option:contains('" + text + "'):gt(0)").remove();
									   
                                        })
		  
								 }
						 }
		 }
		
	// alert(address);
	  }
	  
	
  $(document).ready(function(){
  	               
				           address();
				          
							 });