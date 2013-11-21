window.intime = window.intime || {};
intime = window.intime;
$.extend(intime, {
    addresslist: {
        _citypath:"front/supportshipments.json",
        _$cities:null,
        init:function(){
            this._loadCities();	
        },
       
        _clearCities:function (cityCtrl,disCtrl){
            cityCtrl.empty();
            disCtrl.empty();
            cityCtrl.append("<option>请选择城市</option>");
            disCtrl.append("<option>请选择市区</option>");
        },
        _clearDistricts: function (disCtrl) {
            disCtrl.empty();
            disCtrl.append("<option>请选择市区</option>");
        },
       
        provinceChanged:function(){
            var _this = intime.addresslist;
            var _cityCtrl = $(this).parent().find("select[name='address[shippingprovinceid]'] + select[name='address[shippingcityid]']");
            var _distrCtrl = $(this).parent().find("select[name='address[shippingprovinceid]'] + select[name='address[shippingdistrictid]']");
            _this._clearCities();
            var pid = $(this).val();
            _this._$cities.each(function(){
                var one = this;
                if(pid == one.provinceid) {
                    var ci = one.items;
                    var j =0,length =ci.length;
                    for(; j<length; j++) {
                        _cityCtrl.append("<option value='" + one.items[j].cityid + "'>" + one.items[j].cityname + "</option>");
                    }
										 
                }
            });
        },
        cityChanged:function(){
            var _this = intime.addresslist;
            var _distrCtrl = $(this).parent().find("select[name='address[shippingprovinceid]'] + select[name='address[shippingdistrictid]']");
            _this._clearDistricts(_distrCtrl);
            var cid = $(this).val();
            _this._$cities.each(function(){
                var one = this;
                var j= 0,leng =  one.items.length;
                for(; j<leng; j++){
                    if(one.items[j].cityid==cid){
                        var q=0,leg=one.items[j].items.length;
                        for(;q<leg;q++){
                            _distrCtrl.append("<option value='" + one.items[j].items[q].districtid + "'>" + one.items[j].items[q].districtname + "</option>");
                        }
                    }
                }
            });
        },
     
        _loadCities:function(){
            $.ajax({
                url: this._cityUrl(),
                dataType:'jsonp',
                async:true,
                success:function(data){
                    intime.addresslist._$cities = $(data.datas);
                    $("select[name='address[shippingprovinceid]']").each(function(){                        
                        var provinceCtrl = $(this);
                        provinceCtrl.change(intime.addresslist.provinceChanged);
                        intime.addresslist._$cities.each(function(){
                             var one = this;
                            provinceCtrl.append("<option value='"+one.provinceid+"'>"+one.provincename+"</option>");
                        });
                        var pid = provinceCtrl.prop('data-value');
                        if (pid) {
                            provinceCtrl.val(pid).prop('selected', true);
                            provinceCtrl.change();
                        }
                        
                    });
                    $("select[name='address[shippingcityid]']").each(function () {
                        var cityCtrl = $(this);
                        cityCtrl.change(intime.addresslist.cityChanged);
                       
                        var cid = cityCtrl.prop('data-value');
                        if (cid) {
                            cityCtrl.val(cid).prop('selected', true);
                            cityCtrl.change();
                        }

                    });
                    $("select[name='address[shippingdistrictid]']").each(function () {
                        var districtCtrl = $(this);

                        var did = districtCtrl.prop('data-value');
                        if (did) {
                            districtCtrl.val(did).prop('selected', true);
                        }

                    });
                }
            });
        },
     
        _cityUrl:function(){
            return intime.env.host+this._citypath;
        },
       
    }
});