		var getParam = function(name){
        var search = document.location.search;
        var pattern = new RegExp("[?&]"+name+"\=([^&]+)", "g");
        var matcher = pattern.exec(search);
        var items = null;
        if(null != matcher){
                try{
                        items = decodeURIComponent(decodeURIComponent(matcher[1]));
                }catch(e){
                        try{
                                items = decodeURIComponent(matcher[1]);
                        }catch(e){
                                items = matcher[1];
                        }
                }
        }
        return items;
};
 product_id = getParam('product_id');
function get_jifen(){
	  var quantity = $("#goods_num").val();
	           $.ajax({
					     
						 //type:"get",
						 url:'http://stage.youhuiin.com/front/orders_computeamount',
						 data:{productid:product_id,quantity:quantity},
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