// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery.min.js
//= require jquery_ujs
//= require jquery.ui.widget
//= require bootstrap.min.js
//= require jquery.form.js
//= require jquery.validate.js
//= require jquery.metadata.js
//= require jquery.validate.messages_zh.js
//= require jquery.validate.my.js
//= require jquery.swipeshow.js
//= require jquery.fileupload.js
//= require ims/bootstrap-editable.js
//= require ims/jquery-barcode.js
//= require ims/idangerous.swiper.js
//= require_self

function show_loading_img(){
  img = "<div class='loading'><img src='/images/ims/loading.gif'/></div>";
  $("body").append(img);
};

function hide_loading_img(){
  $(".loading").remove();
};

function error_modal(txt){
		$("#ex2").html("<div class='text-center'><div class='txt4 txt-red'>温馨提示</div><div class='txt4'>"+txt+"</div><a class='btn btn-danger btn-small btn-block btn-modal' href='javascript:void();' data-dismiss='modal' aria-hidden='true' >OK</a></div>")
	 $("#ex2").modal();
}

function format_img(obj){
    $(obj).each(function(){
          $(this).css("height", $(this).width())
          $(this).css("line-height", $(this).height()+"px")
      });
}


var expired_in = 0;
var fnTimeCountDown = function(o){
    var f = {
        zero: function(n){
            var n = parseInt(n, 10);
            if(n > 0){
                if(n <= 9){
                    n = "0" + n;
                }
                return String(n);
            }else{
                return "00";
            }
        },
        dv: function(){
            var dur = expired_in;
            var pms = {
                sec: "00",
                mini: "00",
                hour: "00",
                day: "00",
                month: "00",
                year: "0"
            };
            if(dur > 0){
                pms.day = Math.floor(dur / (60 * 60 * 24));
                pms.hour = Math.floor(dur / (60 * 60)) % 24;
                pms.mini = Math.floor(dur / 60) % 60;
                pms.sec = Math.floor(dur) % 60;
                expired_in = expired_in - 1;
            }
            return pms;
        },
        ui: function(){
            if(o.sec){
                o.sec.innerHTML = f.dv().sec;
            }
            if(o.mini){
                o.mini.innerHTML = f.dv().mini;
            }
            if(o.hour){
                o.hour.innerHTML = f.dv().hour;
            }
            if(o.day){
                o.day.innerHTML = f.dv().day;
            }
            if(o.month){
                o.month.innerHTML = f.dv().month;
            }
            if(o.year){
                o.year.innerHTML = f.dv().year;
            }
            setTimeout(f.ui, 1000);
        }
    };
    f.ui();
};


