window.intime = window.intime || {};
intime = window.intime;
$.extend(intime, {
    order: {
        _citypath:"front/supportshipments.json",
        _computepath:"front/orders/computeamount.json",
        _colorpath:"front/orders/new.json?product_id=",
        _ordercreatepath:"front/orders.json",
        _$cities:null,
        _productid:0,
        init:function(){
            this._productid=this._parseParam('product_id');
            this._loadCities();
            this._get_jifen();
            $("#goods_num").change(this._get_jifen);
            
            $('.change-goods-num').iVaryVal(intime,function(value,index){
                    $('.goods-num').html(value);
                    $("#goods_num").change();
                });		
        },
        empty_shengsyxd:function (){
            $("#cheng_syxd").empty();
            $("#qusyxd").empty();
		
            $("#cheng_syxd").append("<option>请选择城市</option>");
            $("#qusyxd").append("<option>请选择所在区县</option>");
        },
        empty_chengsyxd:function (){
            $("#qusyxd").empty();
            $("#qusyxd").append("<option>请选择所在区县</option>");
        },
        empty_sheng:function (){
            $("#cheng").empty();
            $("#qu").empty();
		 
            $("#cheng").append("<option>请选择城市</option>");
            $("#qu").append("<option>请选择市区</option>");
        },
        empty_cheng:function (){
            $("#qu").empty();
            $("#qu").append("<option>请选择市区</option>");
        },
        empty_f:function (){
            $("#city").empty();
            $("#county").empty();
			
            $("#county").append("<option>请选择城市</option>");
            $("#city").append("<option>请选择城市</option>");
        },
        empty_h:function (){
            $("#county").empty();
            $("#county").append("<option>请选择城市</option>");
        },
        provinceChanged:function(pid,flag,targetSelector){
            var _this = intime.order;
            if (flag==1) {
                _this.empty_sheng();
            } else if(flag==2){
                _this.empty_shengsyxd();
            }else if (flag==3){
                _this.empty_f();
            }
            _this._$cities.each(function(){
                var one = this;
                if(pid == one.provinceid) {
                    var ci = one.items;
                    var j =0,length =ci.length;
                    for(; j<length; j++) {
                        $(targetSelector).append("<option value='"+one.items[j].cityid+"'>"+one.items[j].cityname+"</option>");
                    }
										 
                }
            });
        },
        cityChanged:function(cid,flag,targetSelector){
            var _this = intime.order;
            if (flag==1) {
                _this.empty_cheng();
            } else if(flag==2){
                _this.empty_chengsyxd();
            }else if (flag==3){
                _this.empty_h();
            }
            _this._$cities.each(function(){
                var one = this;
                var j= 0,leng =  one.items.length;
                for(; j<leng; j++){
                    if(one.items[j].cityid==cid){
                        var q=0,leg=one.items[j].items.length;
                        for(;q<leg;q++){
                            $(targetSelector).append("<option value='"+one.items[j].items[q].districtid+"'>"+one.items[j].items[q].districtname+"</option>");
                        }
                    }
                }
            });
        },
        _get_jifen:function (){
            var quantity = $("#goods_num").val();
            $.ajax({
				type:'post',
                url:intime.order._computeUrl(),
                data:{productid:intime.order._productid,quantity:quantity},
                dataType:'json',
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
			
        },
        add_order:function (){
            var goods_color = $("#goods_color").text();
            var goods_size = $("#goods_size").text();
            var goods_num = $("#goods_num").val();
            var shippingperson=$("#shippingperson").text();
            var shippingprovince=$("#shippingprovince").text();
            var shippingaddress=$("#shippingaddress").text();
            var shippingzipcode=$("#shippingzipcode").text();
            var shippingphone=$("#shippingphone").text();
            var supportpayments=$("input[name='supportpayments']:checked").val();
            var supportpayments_name=$("input[name='supportpayments']:checked").attr('data-payname');
            var company_name=$("#company_name").val();
            var bill_comments=$("#bill_comments").find("option:selected").val();
            var dis_comments=$("#dis_comments").val();
            var colorvalueid = $(".yanse").val();
            var colourid = $("#colourid").val();
            var sizeid = $("#sizeid").val();
            var invoice = $("#invoice").find("option:selected").val();
			if (invoice == 'invoice_2') {
				invoice = $("#company_name").val();
			} else {
				invoice = $("#invoice").find("option:selected").text();
			}
			
            var product = new Object();
            var propertie = new Object();
            var order = new Object();
            var address = new Object();
            var pay = new Object();

            if(goods_color==""){	 
                alert("请选择相应的颜色！");
                return;
            }else if(goods_size==""){
                alert("请选择大小尺寸！");
                return;
            }else if(supportpayments==null){
                alert("请选择您的支付方式！");
                return;
            } else if(shippingzipcode==""){
				alert("地址邮编不能为空！");
				return;
			} else if(invoice ==''){
				alert("发票抬头不能为空");
				return;
			} else {
                pay.paymentcode=supportpayments;//"支付方式代码";
                pay.paymentname=supportpayments_name;//"支付方式名";
                address.shippingcontactperson = shippingperson; //"收货联系人";
                address.shippingcontactphone = shippingphone;//"收货联系电话";
                address.shippingzipcode = shippingzipcode;//"收货地址邮编";
                address.shippingaddress = shippingaddress;//"收货地址";
				
                product.productid=this._productid;//product_id传入对应的商品id
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
				  
                var order = JSON.stringify(order);//转义json
                $("#add_order").attr("disabled","disabled"); 
                $("#add_order").text('订单提交中...'); 

                $.ajax({
                    type:'post',
                    url: intime.env.host+this._ordercreatepath,
                    dataType: 'json',
                    data: {order: order}, 
                    success: function(data){
							
                        var check1 = data.isSuccessful.toString();
                        var check2 ="true";
                        if(check1==check2){
                            $("#order_id").html(data.data.order_no);
                            $("#payment_name").html(data.data.payment_name);
                            $("#payment").attr("href",data.data.payment_url);
                             $('#barcode012').modal('show');
                             $("#check_order").attr("href",data.data.order_url);
		
                        } else {
                            $('#barcode012').modal('hide');
                            alert(data.message);
                        }
							
                    }
                }).always(function(){
                    $("#add_order").removeAttr("disabled"); 
                    $("#add_order").text('提交订单'); 
                });
            }
        },
        _loadCities:function(){
            $.ajax({
                url: this._cityUrl(),
                dataType:'json',
                async:true,
                success:function(data){
                    intime.order._$cities = $(data.datas);
                    intime.order._$cities.each(function(){
                        var one = this;
                        $("#province").append("<option value='"+one.provinceid+"'>"+one.provincename+"</option>");
                        $("#sheng").append("<option value='"+one.provinceid+"'>"+one.provincename+"</option>");
                        $("#sheng_syxd").append("<option value='"+one.provinceid+"'>"+one.provincename+"</option>");
                    });
					intime.order._loadColors();
					intime.orderaddress.init();		
                }
            });
        },
        _loadColors:function(){
            $.ajax({			 
                type:"get",			 
                url:this._colorUrl(),
                dataType:'json',
                async:true,
                success:function(data){
                    var i=0,length = data.data.salecolors.length;
                    var len = data.data.address;
	
                    if(len==null){
                        $('#no_address').show();
                        $('#have_adress').hide();
                    } else {
                        $('#no_address').hide();
                        $('#have_adress').show();
                    }
                    for(; i<length; i++) {
                        var j=0, le= data.data.salecolors[i].sizes.length;
                        if(i==0){
                            $('#myTab').append("<button type='button' value='"+data.data.salecolors[i].colorid+"'  onClick=$('#goods_color').text($(this).text()),$('#colourid').val($(this).val()),$('#order_img').attr('src','"+data.data.salecolors[i].images_url+"') href='#tab"+i+"' data-toggle='tab' class='btn'>"+data.data.salecolors[i].colorname+"</button>");
                            $('#myTab button:first').click();
                            $('#sss').append("<div  class='prop mb20 tab-pane active in' id='tab"+i+"' data-toggle='buttons-radio'><span class='tages'>尺码</span></div>");
                        } else {
                            $('#myTab').append("<button type='button' value='"+data.data.salecolors[i].colorid+"'  onClick=$('#goods_color').text($(this).text()),$('#colourid').val($(this).val()),$('#order_img').attr('src','"+data.data.salecolors[i].images_url+"') href='#tab"+i+"' data-toggle='tab' class='btn'>"+data.data.salecolors[i].colorname+"</button>");
                            $('#sss').append("<div class='prop mb20 tab-pane  in' id='tab"+i+"' data-toggle='buttons-radio'><span class='tages'>尺码</span></div>");
                        }
                        for(;j<le;j++){
                            $('#tab'+i).append("<button type='button' value='"+data.data.salecolors[i].sizes[j].sizeid+"' class='btn' onClick=$('#goods_size').text($(this).text()),$('#sizeid').val($(this).val())>"+data.data.salecolors[i].sizes[j].sizename+"</button>");
                        }
                    }
					$(".infobox>.head>h1").html(data.data.name);					 
                    $("#originprice").html(data.data.originprice);
                    $("#price").html(data.data.price);
                    $('#huohao').html(data.data.skucode);
					$('.infobox .brand').html(data.data.brandname+'<br>'+data.data.brand2name);
                    var m=0,supportpayments =  data.data.supportpayments.length;
                    for(; m<supportpayments; m++){
                        $('#supportpayments').append("<label><input name='supportpayments' type='radio' data-payname='"+data.data.supportpayments[m].name+"'  value='"+data.data.supportpayments[m].code+"'/>"+data.data.supportpayments[m].name+"</label>");
                    }
					if (data.data.address) {
						$('#shippingperson').html(data.data.address.shippingperson);
						//显示价格下的省份地址等
						$('#shippingprovince').html(data.data.address.shippingprovince+" "+data.data.address.shippingcity+" "+data.data.address.shippingdistrict);
						$('#shippingaddress').html(data.data.address.displayaddress); 
						$('#shippingzipcode').html(data.data.address.shippingzipcode); 
						$('#shippingphone').html(data.data.address.shippingphone); 
						$('#edit_user').val(data.data.address.shippingperson);
						$('#edit_address').val(data.data.address.shippingaddress);
						$('#edit_code').val(data.data.address.shippingzipcode);
						$('#edit_phone').val(data.data.address.shippingphone);

						$('#addressid').val(data.data.address.id);
						intime.orderaddress.refresh_editzone(data.data.address.shippingprovinceid,data.data.address.shippingcityid,data.data.address.shippingdistrictid);
					}
                }
            });
        },
        _cityUrl:function(){
            return intime.env.host+this._citypath;
        },
        _computeUrl:function(){
            return intime.env.host+this._computepath;
        },
        _colorUrl:function(){
            return intime.env.host+this._colorpath+this._productid;
        },
        _parseParam:function(name){
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
        }
    }
});
