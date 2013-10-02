// JavaScript Document
$(function() {
	

	$('.sidenav .aside').affix({
		offset: {top: 0, bottom: 70}
	})
	
	
	//导航遮罩
	$(".btn-navbar").click(function(){
		$("#navMask").addClass("on");
	});
	$("#navMask").click(function(){
		$(".aside").collapse("hide");
		$("#navMask").removeClass("on");
	});


	
	//首页广告图
	$('#banner').royalSlider({
		//arrowsNav: false,是否用箭头导航,默认true
		loop: true,//是否从最后一张幻灯片滑动到第一张
		controlsInside: false,
		imageScaleMode: 'fill',//图片缩放模式	“fill”, “fit”, “fit-if-smaller” 或 “none”
		autoScaleSlider: true,//是否基于基础宽度自动更新滑块高度	true或false
		arrowsNavHideOnTouch: true,//箭头导航是否在触摸设备中隐藏 true或fa
		autoScaleSliderWidth: 880,//幻灯片基础宽度   
		autoScaleSliderHeight: 300,//幻灯片基础高度
		slidesSpacing: 0,//幻灯片之间的间隔，单位px
		controlNavigation: 'bullets',//导航类型	‘bullets’, ‘thumbnails’, ‘tabs’ 或 ‘none’
		navigateByClick: true,//是否允许在幻灯片上点击鼠标导航	true或false
		autoPlay: {
    		// autoplay options go gere
    		enabled: true,
    		pauseOnHover: true
    	},
		transitionType:'move',//切换过渡类型	‘move’ 或 ‘fade’
	});

	//产品页面图片
	$('#picbox').royalSlider({
		loop: true,
		controlsInside: false,
		imageScaleMode: 'fill',
		arrowsNavAutoHide: true,//箭头导航是否自动隐藏	true或false
		arrowsNavHideOnTouch: false,//箭头导航是否在触摸设备中隐藏 true或false
		autoScaleSlider: true,
		autoScaleSliderWidth: 400,  
		autoScaleSliderHeight: 400,
		slidesSpacing: 0,
		controlNavigation: 'bullets',
		navigateByClick: true,
		autoPlay: false,
		transitionType:'move'
	});
	
	

    //案例
    $(".portfolio .thumbnails .thumbnail .action").hover(function() {
        $(this).find("p").fadeIn(200);
    },
    function() {
        $(this).find("p").fadeOut(100);
    });
	
	
	//产品数量选择器
	$(".goodsNumMinus").click(function(){
		if(parseInt($(".goods-num")[0].value)>1){
			var i = parseInt($(".goods-num")[0].value) - 1;
			$(".goods-num")[0].value= i;
			$(".thjexj").text((parseInt($(".tkje").text())*i).toFixed(2));
		}
	});
	$(".goodsNumPlus").click(function(){
		var t = parseInt($(".goods-num")[0].name);
		if(parseInt($(".goods-num")[0].value)<t){
		var i = parseInt($(".goods-num")[0].value) + 1;
		$(".goods-num")[0].value= i;
		$(".thjexj").text((parseInt($(".tkje").text())*i).toFixed(2));
		}
	});
	$(".goods-num").blur(function(){
		var t = parseInt($(".goods-num")[0].name);
		var g = parseInt($(".goods-num")[0].value);
		if(g>t){
			$(".goods-num")[0].value = t;
			$(".thjexj").text((parseInt($(".tkje").text())*t).toFixed(2));
		}
		else if(g<1){
			$(".goods-num")[0].value = 1;
			$(".thjexj").text((parseInt($(".tkje").text())*1).toFixed(2));
		}	
		else{
			$(".thjexj").text((parseInt($(".tkje").text())*g).toFixed(2));}
	});
	
	



});