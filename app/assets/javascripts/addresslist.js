window.intime = window.intime || {};
intime = window.intime;
$.extend(intime, {
    addresslist: {
        _citypath: "front/supportshipments.json",
        _$cities: null,
        init: function () {
            this._loadCities();
        },

        _clearCities: function (cityCtrl, disCtrl) {
            cityCtrl.empty();
            disCtrl.empty();
            cityCtrl.append("<option>请选择城市</option>");
            disCtrl.append("<option>请选择市区</option>");
        },
        _clearDistricts: function (disCtrl) {
            disCtrl.empty();
            disCtrl.append("<option>请选择市区</option>");
        },

        provinceChanged: function () {
            var _this = intime.addresslist;
            var pid = $(this).val();
            var inputProvCtrl = $(this).parent().find("select[name='address[shippingprovinceid]'] ~ #address_shippingprovince");
            inputProvCtrl.val($(this).find("option:selected").text());
            var _cityCtrl = $(this).parent().find("select[name='address[shippingprovinceid]'] ~ select[name='address[shippingcityid]']");
            var _distrCtrl = $(this).parent().find("select[name='address[shippingprovinceid]'] ~ select[name='address[shippingdistrictid]']");
            _this._clearCities(_cityCtrl, _distrCtrl);

            _this._$cities.each(function () {
                var one = this;
                if (pid == one.provinceid) {
                    var ci = one.items;
                    var j = 0, length = ci.length;
                    for (; j < length; j++) {
                        _cityCtrl.append("<option value='" + one.items[j].cityid + "'>" + one.items[j].cityname + "</option>");
                    }

                }
            });
            _cityCtrl.change();
        },
        cityChanged: function () {
            var _this = intime.addresslist;
            var inputCtrl = $(this).parent().find("select[name='address[shippingprovinceid]'] ~ #address_shippingcity");
            inputCtrl.val($(this).find("option:selected").text());
            var _distrCtrl = $(this).parent().find("select[name='address[shippingprovinceid]'] ~ select[name='address[shippingdistrictid]']");
            _this._clearDistricts(_distrCtrl);
            var cid = $(this).val();
            _this._$cities.each(function () {
                var one = this;
                var j = 0, leng = one.items.length;
                for (; j < leng; j++) {
                    if (one.items[j].cityid == cid) {
                        var q = 0, leg = one.items[j].items.length;
                        for (; q < leg; q++) {
                            _distrCtrl.append("<option value='" + one.items[j].items[q].districtid + "'>" + one.items[j].items[q].districtname + "</option>");
                        }
                    }
                }
            });
            _distrCtrl.change();
        },
        districtChanged: function () {
            var inputCtrl = $(this).parent().find("select[name='address[shippingprovinceid]'] ~ #address_shippingdistrict");
            inputCtrl.val($(this).find("option:selected").text());
        },
        _loadCities: function () {
            $.ajax({
                url: this._cityUrl(),
                dataType: 'jsonp',
                async: true,
                success: function (data) {
                    intime.addresslist._$cities = $(data.datas);
                    $("select[name='address[shippingprovinceid]']").each(function () {
                        var provinceCtrl = $(this);
                        provinceCtrl.append("<option>请选择省份</option>");
                        intime.addresslist._$cities.each(function () {
                            var one = this;
                            provinceCtrl.append("<option value='" + one.provinceid + "'>" + one.provincename + "</option>");
                        });
                        provinceCtrl.change(intime.addresslist.provinceChanged);
                        var pid = provinceCtrl.attr('data-value');
                        if (pid != undefined) {
                            provinceCtrl.val(pid).attr('selected', true);
                            provinceCtrl.change();
                        }

                    });
                    $("select[name='address[shippingcityid]']").each(function () {
                        var cityCtrl = $(this);
                        cityCtrl.change(intime.addresslist.cityChanged);

                        var cid = cityCtrl.attr('data-value');
                        if (cid != undefined) {
                            cityCtrl.val(cid).attr('selected', true);
                            cityCtrl.change();
                        }

                    });
                    $("select[name='address[shippingdistrictid]']").each(function () {
                        var districtCtrl = $(this);
                        districtCtrl.change(intime.addresslist.districtChanged);
                        var did = districtCtrl.attr('data-value');
                        if (did != undefined) {
                            districtCtrl.val(did).attr('selected', true);
                        }

                    });
                }
            });
        },

        _cityUrl: function () {
            return intime.env.host + this._citypath;
        },

    }
});
