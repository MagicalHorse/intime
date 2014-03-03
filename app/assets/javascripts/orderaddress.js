window.intime = window.intime || {};
intime = window.intime;
$.extend(intime, {
    orderaddress: {
        _addresspath:"front/addresses.json",
        _addaddresspath:"front/addresses.json",
        _updateaddresspath:"front/addresses/",
        _address:null,
        init:function(){
            $.ajax({
                url:intime.env.host+this._addresspath,
                dataType:'json',
                async:true,
                success:function(data){
                    intime.orderaddress._address = $(data.datas);
                    var html="";
                    intime.orderaddress._address.each(function(){
                        var one = this;
                        html+= intime.orderaddress._address_list_new_html(one);
                    });
                    $("#address").append(html);
                }
            });
        },
        change:function (){	 
            var addressid = $("input[name='RadioGroup1']:checked").val();
            intime.orderaddress._address.each(function(){
                var one = this;
                if(one.id == addressid){
                    $('#shippingperson').html(one.shippingperson);
                    $('#shippingprovince').html(one.shippingprovince+" "+one.shippingcity+" "+one.shippingdistrict); 
                    $('#shippingaddress').html(one.displayaddress); 
                    $('#shippingzipcode').html(one.shippingzipcode); 
                    $('#shippingphone').html(one.shippingphone); 	 
                    $("#edit_user").val(one.shippingperson);
	
                    $("#edit_address").val(one.shippingaddress);
                    $("#edit_code").val(one.shippingzipcode);
                    $("#edit_phone").val(one.shippingphone);
                    intime.orderaddress.refresh_editzone(one.shippingprovinceid,one.shippingcityid,one.shippingdistrictid);
                }
            });
        },
        add_address:function (){
            var name=$("#username").val();
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

            $.ajax({
                type:"post",
                url:intime.env.host+this._addaddresspath,
                data:{'address':address},
                dataType:'json',
                async:true,
                success:function(data){
                    var check1 = data.isSuccessful.toString();
                    var check2 ="true";
                    if(check1==check2){
                        intime.orderaddress._new_address_insert(data);	
                        $('#add02').collapse('hide');
                        						
						$('#no_address').hide();
                        $('#have_adress').show();
                    } else {
                        alert(data.message);
                    }   
                }
            });
        },
        new_address:function (){
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
				type:'post',
                url:intime.env.host+this._addaddresspath,
                data:{'address':address},
                dataType:'json',
                async:true,
                success:function(data){
                    var check1 = data.isSuccessful.toString();
                    var check2 ="true";
                    if(check1==check2){
						intime.orderaddress._new_address_insert(data);		
                        $('#add01').collapse('hide');	   
                        

                    }
                }
            });
        },
        edit_address:function (){  
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
            $.ajax({
                type:"put",
                url:intime.env.host+this._updateaddresspath+addressid+'.json',
                data:{'address':address},
                dataType:'json',
                async:true,
                success:function(data){
                    var check1 = data.isSuccessful.toString();
                    var check2 ="true";
                    if(check1==check2){
                        //更新之后显示一致
                        $('#shippingperson').html(data.data.shippingperson);
                        $('#shippingprovince').html(data.data.shippingprovince+" "+data.data.shippingcity+" "+data.data.shippingdistrict); 
                        $('#shippingaddress').html(data.data.displayaddress); 
                        $('#shippingzipcode').html(data.data.shippingzipcode); 
                        $('#shippingphone').html(data.data.shippingphone);		  
                        $('#edit_user').html(data.data.shippingperson);
                        $('#edit_address').html(data.data.shippingaddress);
                        $('#edit_code').html(data.data.shippingzipcode);
                        $('#edit_phone').html(data.data.shippingphone);
                        intime.orderaddress.refresh_editzone(data.data.shippingprovinceid,data.data.shippingcityid,data.data.shippingdistrictid);
								   
                        $('#alter01').collapse('hide');
                    } else {
                        $('#alter01').collapse('show');
                        alert(data.message);
                    }
                }
            });
        },

        refresh_editzone: function (pid,cid,did) {
            $("#sheng").val(pid).prop('selected', true);
            $("#sheng").change();
            $("#cheng").val(cid).prop('selected', true);
            $("#cheng").change();
			$("#qu").val(did).prop('selected',true);

        },
		_new_address_insert: function(data){
			$('#shippingperson').html(data.data.shippingperson);
			$('#shippingprovince').html(data.data.shippingprovince+" "+data.data.shippingcity+" "+data.data.shippingdistrict); 
			$('#shippingaddress').html(data.data.displayaddress); 
			$('#shippingzipcode').html(data.data.shippingzipcode); 
			$('#shippingphone').html(data.data.shippingphone);   
			$("#edit_user").val(data.data.shippingperson);
			$("#edit_address").val(data.data.shippingaddress);
			$("#edit_code").val(data.data.shippingzipcode);
			$("#edit_phone").val(data.data.shippingphone);
			$("#address").append(intime.orderaddress._address_list_new_html(data.data));
			intime.orderaddress.refresh_editzone(data.data.shippingprovinceid,data.data.shippingcityid,data.data.shippingdistrictid);
		},
		_address_list_new_html:function(one){
			var html = "";
			html+="<label style='padding:0'>";
			html+="<div class='item'>";
			html+="<div class='item_tit thzq lh25'>";
			html+="<input  type='radio'  name='RadioGroup1' value='"+one.id+"' id='RadioGroup1_1'>";
			html+="<span>收货人：</span><span id='consignee_name'>"+one.shippingperson+"</span><br>";
			html+="<span>手机号码：</span><span id='consignee_phone'>"+one.shippingphone+"</span><br>";
			html+="<span>省份：</span>"+one.shippingprovince+"-"+one.shippingcity+"-"+one.shippingdistrict+"<br>";
			html+="<span>收货地址：</span>"+one.shippingaddress+"<br>";
			html+="<span>邮编：</span>"+one.shippingzipcode+"<br>";
			html+="</div>";
			html+="</div>";
			html+="</label>";
			return html;
		}
		
    }
});