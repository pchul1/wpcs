$(document).ready(function(){
  
  // gnb 동작부분
  $("div#submenu").find(">div").hide().andSelf().hide();

  $("div#gnb ul li").mouseover(function(){
    var _idx = $(this).index();    
    $("div#submenu").show().find("div.sub_gnb0"+(_idx+1)).show().siblings().hide();
    
  });

  $("div#submenu").mouseleave(function(){
    $("div#submenu").hide();
  });


  //메인페이지 이미지 롤링부분
  var cnt=0;
  
  $("div.section_visual ul li").not(":first").hide();

  $("div.section_visual p.point > img").click(function(){        
        clearTimeout(rolling);
        var _idx2 = $(this).index();
        banner_view(_idx2); 
        banner_start();
    });

    function banner_start(){
        rolling =setInterval(function (){
        cnt++;banner_view(cnt%3);},2000);   
        //cnt++;banner_view(cnt%4);},2000); 
    }

    function banner_view(n){    
        $("div.section_visual ul li").eq(n).show().siblings().hide();

        $("div.section_visual p.point > img").eq(n).attr("src",function(){
            var _src = $(this).attr("src");
            return _src.replace("02.png","01.png");
        }).siblings().attr("src",function(){
            var _src = $(this).attr("src");
            return _src.replace("01.png","02.png");
        });
    }

    banner_start();

});