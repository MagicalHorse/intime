function GetRequest() {
   var url = location.search; //获取url中"?"符后的字串
   var theRequest = new Object();
   if (url.indexOf("?") != -1) {
      var str = url.substr(1);
      strs = str.split("&");
      for(var i = 0; i < strs.length; i ++) {
         theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
      }
   }
   return theRequest;
}
var Request = new Object();
Request = GetRequest();
var name,pwd;
id = Request['id'];
//alert(id); 
function product(){
	             $.ajax({
						 type:"get",
						 url:'do.php',
						 data:{'id':id},
						 dataType:'json',
						 async:true,
						 success:function(data){
							var i=0,length = data.data.salecolors.length;
								 for(; i<length; i++) {
									 var j=0, le= data.data.salecolors[i].sizes.length;
									 //alert(data.data.salecolors[i].colorname);
									 //alert(le);
									 if(i==0){
									 	 $('#myTab').append("<button type='button'  onClick=$('#goods_color').text($(this).text()) href='#tab"+i+"' data-toggle='tab' class='btn'>"+data.data.salecolors[i].colorname+"</button>  ");
									 	 $('#sss').append("<div  class='prop mb20 tab-pane active in' id='tab"+i+"' data-toggle='buttons-radio'><span class='tages'>尺码</span></div>");
									 	} else {
									 		$('#myTab').append("<button type='button' onClick=$('#goods_color').text($(this).text()) href='#tab"+i+"' data-toggle='tab' class='btn'>"+data.data.salecolors[i].colorname+"</button>");
									 		$('#sss').append("<div class='prop mb20 tab-pane  in' id='tab"+i+"' data-toggle='buttons-radio'><span class='tages'>尺码</span></div>");
									 		}
										for(;j<le;j++){
											$('#tab'+i).append("<button type='button' class='btn' onClick=$('#goods_size').text($(this).text())>"+data.data.salecolors[i].sizes[j].sizename+"</button>  ");
											}
									 }
									 //alert(data.data.address.displayaddress);
									 $('#shippingperson').html(data.data.address.shippingperson);
									 $('#shippingprovince').html(data.data.address.shippingprovince+" "+data.data.address.shippingcity+" "+data.data.address.shippingdistrict); 
						       $('#displayaddress').html(data.data.address.displayaddress); 
						       $('#shippingzipcode').html(data.data.address.shippingzipcode); 
						       $('#shippingphone').html(data.data.address.shippingphone); 
						}
					});
	   }
   
  
  $(document).ready(function(){
  	               
				           product();
				          
							 });