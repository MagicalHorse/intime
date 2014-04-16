function show_loading_img(){
  img = "<div class='loading'><img src='/images/ims/loading.gif'/></div>";
  $("body").append(img);
}

function hide_loading_img(){
  $(".loading").remove();
}

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



function resizeMe(img, max_width, max_height) {
  var canvas = document.createElement('canvas');
  var width = img.width;
  var height = img.height;

  // calculate the width and height, constraining the proportions
  if (width > height) {
    if (width > max_width) {
      //height *= max_width / width;
      height = Math.round(height *= max_width / width);
      width = max_width;
    }
  } else {
    if (height > max_height) {
      //width *= max_height / height;
      width = Math.round(width *= max_height / height);
      height = max_height;
    }
  }

  // resize the canvas and draw the image data into it
  canvas.width = width;
  canvas.height = height;
  var ctx = canvas.getContext("2d");
  ctx.drawImage(img, 0, 0, width, height);

  return canvas.toDataURL("image/jpeg",0.7); // get the data from canvas as 70% JPG (can be also PNG, etc.)
}
