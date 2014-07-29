

jQuery.validator.addMethod(
  "dontMorethan",
  function(value, element, param) {
    return this.optional(element) || param >= value
  }, "不能大于上面的值"
)

jQuery.validator.addMethod(
  "id_card",
  function(value, element) {
    value = $.trim(value.toUpperCase())
    // 15 位身份证号码验证
    isCard1=/^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/
    // 18 位身份证号码验证
    //isCard2=/^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/
    isCard2=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])(\d{3})([0-9]|X)$/;
    return isCard1.test(value) || isCard2.test(value) || value.length == 0
  }, "身份证号码不正确"
)

jQuery.validator.addMethod(
  "verify_date_gte",
  function(value, element) {
    $(element).parents(".time_range").find("label.text-error").remove()
    date_ele = $(element).parents(".time_range").find("select")
    value = date_ele.eq(3).val()
    var end_year = date_ele.eq(2).val()
    var end_month  = value.length == 1 ? "0"+value : value
    var start_year = date_ele.eq(0).val()
    var start_month = date_ele.eq(1).val().length == 1 ? "0"+date_ele.eq(1).val() : date_ele.eq(1).val()
    return start_year == "" || start_month == "" || end_year == "" || value == "" || end_year+end_month >= start_year + start_month
  }, "结束日期不能小于开始日期"
)

jQuery.validator.addMethod(
  "require_from_group",
  function(value, element, options) {
    var validator = this;
    var selector = options[1];
    var validOrNot = $(selector, element.form).filter(function() {
      return validator.elementValue(this);
    }).length >= options[0];

    // if(!$(element).data('being_validated')) {
    //   var fields = $(selector, element.form);
    //   fields.data('being_validated', true);
    //   fields.valid();
    //   fields.data('being_validated', false);
    // }
    return validOrNot;
}, jQuery.format("请填写至少{0}项"));


jQuery.validator.addMethod(
  "my_url",
  function( value, element ) {
  if(value.indexOf("http://") >= 0 || value.indexOf("https://") >= 0){
    return this.optional(element) || /^(https?|s?ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(value);
  }else{
    return this.optional(element) || /^(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(value);
  }
}, jQuery.format("请输入正确格式的网址"));


jQuery.validator.addMethod(
  "more_than",
  function(value, element, param) {
    origin_value = value
    origin_end_value = $(param).val()
    value = parseInt(value)
    end_value = parseInt(origin_end_value)
    return origin_value == "" || origin_end_value == "" || value >= end_value
  }, "必须大于"
)


jQuery.validator.addMethod(
  "mobile",
  function(value, element ) {
  return $.trim(value).length == 11 || this.optional(element)
}, jQuery.format("手机号码格式错误"));