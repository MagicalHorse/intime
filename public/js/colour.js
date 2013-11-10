	<!---->
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
 //getParam('product_id');
 <!--商品传递product_id显示对应商品信息-->
function product(){
	             $.ajax({
						 type:"get",
						 url:'http://stage.youhuiin.com/front/orders/new.json?product_id='+product_id,
						 

                         //测试用的product_id 测试成功 加入 product_id 替换 号码
						
						 dataType:'jsonp',
						 async:true,
						 success:function(data){
							var i=0,length = data.data.salecolors.length;
							var len = data.data.address.length;
							if(len==0){
								$('#no_address').show();
								$('#have_adress').hide();
								} else {
									$('#no_address').hide();
									$('#have_adress').show();
									}
								 for(; i<length; i++) {
									 var j=0, le= data.data.salecolors[i].sizes.length;
									 //alert(data.data.salecolors[i].colorname);
									 //alert(le);
									 if(i==0){
									 	 $('#myTab').append("<button type='button' value='"+data.data.salecolors[i].colorid+"' onClick=$('#goods_color').text($(this).text()),$('#colourid').val($(this).val()) href='#tab"+i+"' data-toggle='tab' class='btn'>"+data.data.salecolors[i].colorname+"</button> ");
									 	 $('#sss').append("<div  class='prop mb20 tab-pane active in' id='tab"+i+"' data-toggle='buttons-radio'><span class='tages'>尺码</span></div>");
									 	} else {
									 		$('#myTab').append("<button type='button' value='"+data.data.salecolors[i].colorid+"'  onClick=$('#goods_color').text($(this).text()),$('#colourid').val($(this).val()) href='#tab"+i+"' data-toggle='tab' class='btn'>"+data.data.salecolors[i].colorname+"</button> ");
									 		$('#sss').append("<div class='prop mb20 tab-pane  in' id='tab"+i+"' data-toggle='buttons-radio'><span class='tages'>尺码</span></div>");
									 		}
										for(;j<le;j++){
											$('#tab'+i).append("<button type='button' value='"+data.data.salecolors[i].sizes[j].sizeid+"' class='btn' onClick=$('#goods_size').text($(this).text()),$('#sizeid').val($(this).val())>"+data.data.salecolors[i].sizes[j].sizename+"</button>  ");
											}
									 }
									 
									
									 
									 
									 $("#originprice").html(data.data.originprice);
									 $("#price").html(data.data.price);
									 $('#shippingperson').html(data.data.address.shippingperson);
									<!-- //显示价格下的省份地址等：-->
									 $('#shippingprovince').html(data.data.address.shippingprovince); 
									 
									 
						       $('#displayaddress').html(data.data.address.displayaddress); 
						       $('#shippingzipcode').html(data.data.address.shippingzipcode); 
						       $('#shippingphone').html(data.data.address.shippingphone); 
						       $('#edit_user').val(data.data.address.shippingperson);
						       $('#edit_address').val(data.data.address.displayaddress);
						       $('#edit_code').val(data.data.address.shippingzipcode);
						       $('#edit_phone').val(data.data.address.shippingphone);
							   
							  
							   
							      $("#sheng").append("<option value='"+data.data.address.shippingprovinceid+"'>"+data.data.address.shippingprovince+"</option>");
						       $("#sheng option[value='"+data.data.address.shippingprovinceid+"']").attr("selected", "selected");
							
							 
							  
						       $("#cheng").append("<option value='"+data.data.address.shippingcityid+"'>"+data.data.address.shippingcity+"</option>");
						       $("#cheng option[value='"+data.data.address.shippingcityid+"']").attr("selected", "selected");
						       $("#qu").append("<option value='"+data.data.address.shippingdistrictid+"'>"+data.data.address.shippingdistrict+"</option>");
						       $("#qu option[value='"+data.data.address.shippingdistrictid+"']").attr("selected", "selected");
				           $('#addressid').val(data.data.address.id);
							   $('#huohao').html(data.data.skucode);
							   var m=0,supportpayments =  data.data.supportpayments.length;
							   for(; m<supportpayments; m++){
								   $('#supportpayments').append("<label><input name='supportpayments' type='radio'  value='"+data.data.supportpayments[m].code+"'/>"+data.data.supportpayments[m].name+"</label>");
								   }
						}
					});
					
						   get_jifen();
	   }
   
  
  $(document).ready(function(){
  	               
				           product();
						 
				          
							 });
							 
	<!--积分获取-->
function get_jifen(){
	  var quantity = $("#goods_num").val();
	
	           $.ajax({
					     
						 //type:"get",
						 // //测试用的product_id 测试成功 加入 product_id 替换 号码
						 url:'http://stage.youhuiin.com/front/orders_computeamount',
						 data:{productid:product_id,quantity:quantity},
						 dataType:'jsonp',
						 async:true,
						 success:function(data){
							var check1 = data.isSuccessful.toString();
						    var check2 ="true";
						    if(check1==check2){
								$("#kdf").html("+￥"+data.data.totalfee);
								$("#jidian").html(data.data.totalpoints+"分");
								$("#zj").html("￥"+data.data.totalamount);
								$("#xfkx").html("￥"+data.data.extendprice);
								} else {
									alert(data.message);
									}
						}
					});
				
	   }
	   <!--积分获取1-->
	  function  get_jifenchange(){
		   
		    var quantity = ($("#goods_num").val()-0)+1;
		
	
	           $.ajax({
					     
						 //type:"get",
						 // //测试用的product_id 测试成功 加入 product_id 替换 号码
						 url:'http://stage.youhuiin.com/front/orders_computeamount',
						 data:{productid:product_id,quantity:quantity},
						 dataType:'jsonp',
						 async:true,
						 success:function(data){
							var check1 = data.isSuccessful.toString();
						    var check2 ="true";
						    if(check1==check2){
								$("#kdf").html("+￥"+data.data.totalfee);
								$("#jidian").html(data.data.totalpoints+"分");
								$("#zj").html("￥"+data.data.totalamount);
								$("#xfkx").html("￥"+data.data.extendprice);
								} else {
									alert(data.message);
									
									}
						}
					});
		   }
		   <!--积分获取1-->
		   function  get_jifenchangea(){
		   
		    var quantity = ($("#goods_num").val()-0)-1;
		
	
	           $.ajax({
					     
						 //type:"get",
						 // //测试用的product_id 测试成功 加入 product_id 替换 号码
						 url:'http://stage.youhuiin.com/front/orders_computeamount',
						 data:{productid:product_id,quantity:quantity},
						 dataType:'jsonp',
						 async:true,
						 success:function(data){
							var check1 = data.isSuccessful.toString();
						    var check2 ="true";
						    if(check1==check2){
								$("#kdf").html("+￥"+data.data.totalfee);
								$("#jidian").html(data.data.totalpoints+"分");
								$("#zj").html("￥"+data.data.totalamount);
								$("#xfkx").html("￥"+data.data.extendprice);
								} else {
									alert(data.message);
									}
						}
					});
		   }
