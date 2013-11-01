function get_jifen(){
	  var quantity = $("#goods_num").val();
	           $.ajax({
					     
						 //type:"get",
						 url:'http://stage.youhuiin.com/front/orders_computeamount',
						 data:{productid:487927,quantity:quantity},
						 dataType:'jsonp',
						 async:true,
						 success:function(data){
							var check1 = data.isSuccessful.toString();
						    var check2 ="true";
						    if(check1==check2){
								$("#kdf").html(data.data.totalfee);
								$("#jidian").html(data.data.totalpoints);
								$("#zj").html(data.data.totalamount);
								$("#xfkx").html(data.data.extendprice);
								} else {
									alert(data.message);
									}
						}
					});
				
	   }
   
  
  $(document).ready(function(){
  	               
				           get_jifen();
				          
							 });