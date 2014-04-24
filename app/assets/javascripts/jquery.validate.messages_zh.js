/*
 * Translated default messages for the jQuery validation plugin.
 * Locale: ZH (Chinese, 中文 (Zhōngwén), 汉语, 漢語)
 */
jQuery.extend(jQuery.validator.messages, {
        required: "不能为空",
		remote: "请修正该字段",
		email: "请输入正确格式的电子邮件",
		url: "请输入正确格式的网址",
		date: "请输入正确格式的日期",
		dateISO: "请输入正确格式的日期 (ISO).",
		number: "请输入数字",
		digits: "只能输入整数",
		creditcard: "请输入正确格式的信用卡号",
		equalTo: "前后密码不一致",
		accept: "请输入拥有合法后缀名的字符串",
		maxlength: jQuery.validator.format("长度不能超过 {0}"),
		minlength: jQuery.validator.format("长度至少 {0}"),
		rangelength: jQuery.validator.format("长度介于 {0} 和 {1} 之间"),
		range: jQuery.validator.format("请输入介于 {0} 和 {1} 之间的值"),
		max: jQuery.validator.format("请输入一个最大为 {0} 的值"),
		min: jQuery.validator.format("请输入一个最小为 {0} 的值")
});
