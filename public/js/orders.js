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
 function add_order(){
	 // var goods_color = ('#goods_color').innerHTMLs;
	  var goods_color = $("#goods_color").text();
	  var goods_size = $("#goods_size").text();
	  var goods_num = $("#goods_num").text();
	  var shippingperson=$("#shippingperson").text();
	  var shippingprovince=$("#shippingprovince").text();
	  var displayaddress=$("#displayaddress").text();
	  var shippingzipcode=$("#shippingzipcode").text();
	  var shippingphone=$("#shippingphone").text();
	  var supportpayments=$("input[name='supportpayments']:checked").val();
	  var supportpayments_name=$("input[name='supportpayments']:checked").text();
	  var company_name=$("#company_name").val();
	  var bill_comments=$("#bill_comments").val();
	  var dis_comments=$("#dis_comments").val();
	  var colorvalueid = $(".yanse").val();
	   var colourid = $("#colourid").val();
	  var sizeid = $("#sizeid").val();
	  var invoice = $("#invoice").find("option:selected").text();
	 var product = new Object();
   var propertie = new Object();
   var order = new Object();
   var address = new Object();
   var pay = new Object();
   pay.paymentcode=supportpayments;//"支付方式代码";
   pay.paymentname="支付宝支付";//"支付方式名";//"支付方式名";
    address.shippingcontactperson = shippingperson; //"收货联系人";
	address.shippingcontactphone = shippingphone;//"收货联系电话";
	address.shippingzipcode = shippingzipcode;//"收货地址邮编";
	address.shippingaddress = displayaddress;//"收货地址";
    product.productid=product_id;
    product.desc="";//"商品描述";
	 product.quantity = goods_num;//"商品数量";
	 propertie.sizevalueid = sizeid;//"尺码主键";
	 propertie.sizevaluename = goods_size;//"尺码描述";
	 propertie.colorvalueid = colourid;//"颜色主键";
	 propertie.colorvaluename = goods_color;//"颜色描述";
	 product.properties=propertie;
   order.products = [];
   order.products.push(product)
   order.products.properties = propertie;
   order.needinvoice = 1;//"是否需要发票";
    order.invoicetitle = invoice;//"发票抬头";
	 order.invoicedetail = bill_comments;//"发票明细";
	  order.memo = dis_comments;//"订单备注";
	  order.shippingaddress = address;
	  order.payment = pay;
	var order = JSON.stringify(order);
	//alert(order);
	$.ajax({
		//type:"POST",
        url: 'http://stage.youhuiin.com/front/orders_create',
        dataType: 'jsonp',
        data: {order: order}, // Page parameter to make sure we load new data
        success: function(data){
			    var check1 = data.isSuccessful.toString();
				 var check2 ="true";
				 if(check1==check2){
				 $("#order_id").html(data.data.order_no);
				 $("#payment_name").html(data.data.payment_name);
				 $("#payment").attr('href',data.data.payment_url); 
				 $("#check_order").attr('href',data.data.order_url);      
				  alert(data.message);
				 // alert('ok');
				  $('#barcode012').modal('show');
				 } else {
					$('#barcode012').modal('hide');
					  alert(data.message);
					 }
				
			}
      });
	 
	  }
  function add_address(){
	  var name=$("#name").val();
	  var provinceid = $("#province").val();
	  var province =$("#province").find("option:selected").text();
	  var cityid = $("#city").val();
	  var city = $("#city").find("option:selected").text();
	  var countyid = $("#county").val();
	   var county = $("#county").find("option:selected").text();
	  var shaddress = $("#shaddress").val();
	  var postcode = $("#postcode").val();
	  var cellphone = $("#cellphone").val();
	   var address = new Object();
	  address.shippingperson = name;
	  address.shippingphone = cellphone;
	  address.shippingprovinceid = provinceid;
	  address.shippingprovince = province;
	  address.shippingcityid = cityid;
	  address.shippingcity = city;
	  address.shippingdistrictid = countyid;
	  address.shippingdistrict = county;
	  address.shippingaddress = shaddress;
	  address.shippingzipcode = postcode;
	 //alert(address);
	  $.ajax({
						//type:"POST",//get post不区分大小写
						 url:'http://stage.youhuiin.com/front/addresses_create',
						 data:{'address':address},
						 dataType:'jsonp',
						async:true,
						success:function(data){
						var check1 = data.isSuccessful.toString();
						var check2 ="true";
						if(check1==check2){
							$('#shippingperson').html(data.data.shippingperson);
									 $('#shippingprovince').html(data.data.shippingprovince+" "+data.data.shippingcity+" "+data.data.shippingdistrict); 
						       $('#displayaddress').html(data.data.displayaddress); 
						       $('#shippingzipcode').html(data.data.shippingzipcode); 
						       $('#shippingphone').html(data.data.shippingphone);
							   $('#add02').collapse('hide');
							   alert(data.message);
							} else {
								$('#add02').collapse('show');
								alert(data.message);
								}   
						}
					});
	  }

function new_address(){

var syxd_user=$("#syxd_username").val();
		   var provinceid = $("#sheng_syxd").val();
			  var province =$("#sheng_syxd").find("option:selected").text();
			  var cityid = $("#cheng_syxd").val();
			  var city = $("#cheng_syxd").find("option:selected").text();
			  var countyid = $("#qusyxd").val();
			   var county = $("#qusyxd").find("option:selected").text();
			  var saddress = $("#syxd_address").val();
			  var postcode = $("#syxd_code").val();
			  var cellphone = $("#syxd_phone").val();
			  var syxd_call = $("#syxd_call").val();
			 var address = new Object();
	  address.shippingperson = syxd_user;
	  address.shippingphone = cellphone;
	  address.shippingprovinceid = provinceid;
	  address.shippingprovince = province;
	  address.shippingcityid = cityid;
	  address.shippingcity = city;
	  address.shippingdistrictid = countyid;
	  address.shippingdistrict = county;
	  address.shippingaddress = saddress;
	  address.shippingzipcode = postcode;
$.ajax({
						
						//type:"POST",//get post不区分大小写
						 url:'http://stage.youhuiin.com/front/addresses_create',
						 data:{'address':address},
						 dataType:'jsonp',
						async:true,
						success:function(data){
						var check1 = data.isSuccessful.toString();
						var check2 ="true";
						if(check1==check2){
						       $('#shippingperson').html(data.data.shippingperson);
							   $('#shippingprovince').html(data.data.shippingprovince+" "+data.data.shippingcity+" "+data.data.shippingdistrict); 
						       $('#displayaddress').html(data.data.displayaddress); 
						       $('#shippingzipcode').html(data.data.shippingzipcode); 
						       $('#shippingphone').html(data.data.shippingphone);
							   alert(data.message);
							   $('#add01').collapse('hide');
							} else {
								alert(data.message);
							  $('#add01').collapse('show');
								}
						}
					});
		  }
		  function edit_address(){
			var edit_user = $('#edit_user').val();
				var shengid = $('#sheng').val();
		  	var sheng = $('#sheng').find("option:selected").text();
		  	var chengid = $('#cheng').val();
		  	var cheng = $('#cheng').find("option:selected").text();
		  	var quid = $('#qu').val();
		  	var qu = $('#qu').find("option:selected").text();
			var edit_address = $('#edit_address').val();
		  	var edit_code = $('#edit_code').val();
		  	var edit_phone = $('#edit_phone').val();
			var addressid = $('#addressid').val();
			
			var address = new Object();
		  	address.shippingperson = edit_user;
		  	address.shippingphone = edit_phone;
		  	address.shippingprovinceid = shengid;
		  	address.shippingprovince = sheng;
		  	address.shippingcityid = chengid;
		  	address.shippingcity = cheng;
		  	address.shippingdistrictid = quid;
		  	address.shippingdistrict = qu;
		  	address.shippingaddress = edit_address;
		  	address.shippingzipcode = edit_code;

	     //alert(params);
	    $.ajax({
						//type:"POST",//get post不区分大小写
						 url:'http://stage.youhuiin.com/front/addresses_update/'+addressid,
						 data:{'address':address},
						 dataType:'jsonp',
						async:true,
						success:function(data){
							var check1 = data.isSuccessful.toString();
						var check2 ="true";
						if(check1==check2){
							$('#shippingperson').html(data.data.shippingperson);
									 $('#shippingprovince').html(data.data.shippingprovince+" "+data.data.shippingcity+" "+data.data.shippingdistrict); 
						       $('#displayaddress').html(data.data.displayaddress); 
						       $('#shippingzipcode').html(data.data.shippingzipcode); 
						       $('#shippingphone').html(data.data.shippingphone);
						      
						       $('#edit_user').html(data.data.shippingperson);
						       $('#edit_address').html(data.data.displayaddress);
						       $('#edit_code').html(data.data.shippingzipcode);
						       $('#edit_phone').html(data.data.shippingphone);
							   $('#alter01').collapse('hide');
							   alert(data.message);
							} else {
								$('#alter01').collapse('show');
								alert(data.message);
								}
						}
					});
		  	}