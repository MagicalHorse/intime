var browser={  
    versions:function(){  
    var u = navigator.userAgent, app = navigator.appVersion;  
    return {  
    trident: u.indexOf('Trident') > -1,  //IE内核  
    presto: u.indexOf('Presto') > -1,  //opera内核  
    webKit: u.indexOf('AppleWebKit') > -1,  //苹果、谷歌内核  
    gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,  //火狐内核  
    mobile: !!u.match(/AppleWebKit.*Mobile.*/)||!!u.match(/AppleWebKit/),  //是否为移动终端  
    ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/),  //ios终端  
    android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1,  //android终端或者uc浏览器  
    iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1,  //是否为iPhone或者QQHD浏览器  
    iPad: u.indexOf('iPad') > -1,  //是否iPad  
    webApp: u.indexOf('Safari') == -1  //是否web应该程序，没有头部与底部  
    };  
    }()  
}  


// function show_loading_img(){
//   img = "<div class='loading'><img src='/images/ims/loading.gif'/></div>";
//   $("body").append(img);
// }

// function hide_loading_img(){
//   $(".loading").remove();
// }

var NewBlob = function(data, datatype)
{
    var out;

    try {
        out = new Blob([data], {type: datatype});
        console.log("case 1");
    }
    catch (e) {
        window.BlobBuilder = window.BlobBuilder ||
                window.WebKitBlobBuilder ||
                window.MozBlobBuilder ||
                window.MSBlobBuilder;

        if (e.name == 'TypeError' && window.BlobBuilder) {
            var bb = new BlobBuilder();
            bb.append(data);
            out = bb.getBlob(datatype);
            console.log("case 2");
        }
        else if (e.name == "InvalidStateError") {
            // InvalidStateError (tested on FF13 WinXP)
            out = new Blob([data], {type: datatype});
            console.log("case 3");
        }
        else {
            // We're screwed, blob constructor unsupported entirely   
            console.log("Errore");
        }
    }
    return out;
}

// function isSupportFileApi() {
//     if(window.Blob) {
//       var blob = new NewBlob(["Hello world!"], { type: "text/plain" });
//       return blob;
//     }
//     return false;
// }



function error_modal(txt){
    $("#ex2").html("<div class='text-center'><div class='txt4 txt-red'>错误提示</div><div class='txt4'>"+txt+"</div><a class='btn btn-danger btn-small btn-block btn-modal' href='javascript:void();' data-dismiss='modal' aria-hidden='true' >OK</a></div>")
   $("#ex2").modal();
}

function success_modal(txt){
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



function resizeIos(img, max_width, max_height) {
  var canvas = document.createElement('canvas');
  var mpImg = new MegaPixImage(img);
  if(browser.versions.ios || browser.versions.iPhone || browser.versions.iPad){
    if(img.naturalWidth >= img.naturalHeight){
      mpImg.render(canvas, { maxWidth: max_width, maxHeight: max_height, quality: 0.6, orientation: 8});
    }else{
      mpImg.render(canvas, { maxWidth: max_width, maxHeight: max_height, quality: 0.6});
    }
  }else{
    mpImg.render(canvas, { maxWidth: max_width, maxHeight: max_height, quality: 0.1});
  }

  return canvas.toDataURL("image/jpeg",0.93); // get the data from canvas as 70% JPG (can be also PNG, etc.)
}

function resizeAndroid(img, max_width, max_height) {
    alert("in android");
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
  canvas.width = img.naturalWidth;
  canvas.height = img.naturalHeight;
  var ctx = canvas.getContext("2d");
  ctx.drawImage(img, 0, 0, width, height);

  return canvas.toDataURL("image/jpeg", 0.5); // get the data from canvas as 70% JPG (can be also PNG, etc.)
}
