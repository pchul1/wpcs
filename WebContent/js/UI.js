/*------------------------------------------------
	project:	수질오염 방제정보 시스템
	created:	2013-10-17
------------------------------------------------ */
function include(url) {
	document.write('<script src="' + url + '" type="text/javascript"></script>');
}
//
//  공통  //
//
//  상단메뉴
//------------------------------------------------------------------------------------------
function activeGNB(id) {
	for(num=1; num<=5; num++) {
		//document.getElementById('gm'+num).style.display='none'; //D2MG1~D2MG4 까지 숨긴 다음
		if (document.getElementById('gm'+num) != null) {
			document.getElementById('gm'+num).style.display='none'; //D2MG1~D2MG4 까지 숨긴 다음
		}
	}
	document.getElementById(id).style.display='block'; //해당 ID만 보임
}


//
//  지도  // 
//
//  지도영역 높이값 계산
//------------------------------------------------------------------------------------------
var type = "out";
function resize() {
	//var doc_height = $(document).height();
	var doc_height = $(window).height();
	var con_height;//상하단 제외한 높이
	var mb_height;//지도 외곽 회색테두리박스 높이
	//var m_height; //지도 높이

	con_height = doc_height-237; //브라우저 - (상단+하단)
	mb_height = con_height-50+28; // content영역 - (topinfo높이+하단공백)
	//m_height = mb_height-14; // 지도외곽박스 - padding값
	if(type == "out"){
		mb_height = mb_height + 70;
		$('#mapBox').css("margin-bottom", "10px");
	}else{
		$('#mapBox').css("margin-bottom", "80px");
	}
	
	var chkInfoBxHeight = $("#chkInfoBx").height();
	
	if(mb_height > 640){
		$("#chkInfoBx").height(250+mb_height-640);
		$("#resultBx").height(245+mb_height-640);
	}
	
	$('#gisContent_wrapper').css("height",doc_height+"px");
	$('#mapBox').css("height",mb_height+"px");
	$('#mapBoxBj').css("height",doc_height+"px");
	//$('#map').css("height",m_height+"px");
}

function popUpsize(){
	var p_width = $('#divCenter').width();
	var p_height = $('#divCenter').height();
	var mp_top = p_height-(p_height/2);
	var mp_left =  p_width-(p_width/2);

	$('#divCenter').css("height", p_height+"px");
	$('#divCenter').css("width", p_width+"px");
	$('#divCenter').css("margin-top", "-"+mp_top+"px");
	$('#divCenter').css("margin-left", "-"+mp_left+"px");
}	

var btToggle_flag = false;

(function ($) {

	//------------------------------------------------------------------------------------------	
	$(document).ready(function () {
		
		
		//
		//  site-----------------------------------------------------------------------------------
		//
		// 사이트 좌측 메뉴
		//------------------------------------------------------------------------------------------
		/*$('#nav').accordion({  
			 header: 'div.caption',  
			 selectedClass: 'show',  
			 event: 'click' 
		});  
		*/
		$("dl dt").click(function(){
			if($("+dd",this).css("display")=="none"){
				$("dd").slideUp("slow");
				$("+dd",this).slideDown("slow");
				$("dt").removeClass("selected");
				$(this).addClass("selected");
			}
		}).mouseover(function(){
			$(this).addClass("over");
		}).mouseout(function(){
			$(this).removeClass("over");
		});

		//  map------------------------------------------------------------------------------------------
		// 화면조정
		//------------------------------------------------------------------------------------------
		resize();
		popUpsize();
		$(window).resize(function() {
			resize();
		});
		
		// A. 메뉴
		//------------------------------------------------------------------------------------------	
		$("#leftSearch").organicTabs();

		// B. 검색영역 collapsible 기능  
		//------------------------------------------------------------------------------------------
		$('#searchToggle').toggle(schStart,schEnd);
		
		/**
		 * 2014.10.27 주제도 관련 추가
		 * kyr
		 */
		$('#searchToggleTm').toggle(schStartTm,schEndTm);
		
		// C. tabmenu 기능  
		//------------------------------------------------------------------------------------------
		$(".tab_menu li").click(function(){
			$(this).parent().parent().find("div").hide();
			$(this).parent().parent().find("div").eq($(this).index()).show();
			$(this).parent().find("li").removeClass("on");
			$(this).addClass("on");
		});

		// D. 검색결과영역  collapsible 기능
		//------------------------------------------------------------------------------------------
		$('#resultToggle').toggle(resultStart,resultEnd);
		
		setTimeout(function(){
			$('#resultToggle').trigger('click');
		}, 500);
		
		
		// E. 자동/수동 영역  collapsible 기능
		//------------------------------------------------------------------------------------------
		$('#btTabToggle').toggle(autobtStart,autobtEnd);
		setTimeout(function(){
			$('#btTabToggle').trigger('click');
		}, 500);
		
		$("#tabmenu").organicTabs({
				"speed": 200
		});

		// F. 방제활동지원 우측 collapsible 기능  
		//------------------------------------------------------------------------------------------
		$('#rightToggle').toggle(rStart,rEnd);

		// G. 방제활동지원 tab 기능  
		//------------------------------------------------------------------------------------------
		$('.tabMenu .tab a').bind('click focusin',function(){
			$('.tabMenu .wrap').removeClass('on');
			$(this).parent().parent().addClass('on');
		});
		
		$('#stb01.stabMenu .stab a').bind('click focusin',function(){
			$('#stb01.stabMenu .swrap').removeClass('son');
			$(this).parent().parent().addClass('son');
		});
		$('#stb02.stabMenu .stab a').bind('click focusin',function(){
			$('#stb02.stabMenu .swrap').removeClass('son');
			$(this).parent().parent().addClass('son');
		});
		$('#stb03.stabMenu .stab a').bind('click focusin',function(){
			$('#stb03.stabMenu .swrap').removeClass('son');
			$(this).parent().parent().addClass('son');
		});
		$('#stb04.stabMenu .stab a').bind('click focusin',function(){
			$('#stb04.stabMenu .swrap').removeClass('son');
			$(this).parent().parent().addClass('son');
		});
		// H. 방제활동지원 하단 collapsible 기능  
		//------------------------------------------------------------------------------------------
		$('#btToggle').toggle(bStart,bEnd);

		// I. 상단 반경검색 슬라이더  
		//------------------------------------------------------------------------------------------
		$( "#slider3" ).slider({
			min:0, max:0.5,
			value: 0,
			orientation: "horizontal",
			range: "min",
			step:0.1,
			animate: true
		});

		 // J. 방제활동지원 상단 collapsible 기능  
		//------------------------------------------------------------------------------------------
		$('#tpToggle').toggle(tStart,tEnd);

	});
	


	//  DocReady
	//------------------------------------------------------------------------------------------


	// B-1. left search collapsible 기능 함수
	//------------------------------------------------------------------------------------------
	function schStart(){
	$('#leftSearchBx').animate({left:'-=306px'},200);
	$('#searchToggle img').attr('src','/images/renewal2/toggle_out.png');
	$('#searchToggle img').attr('alt','열기');
	}
	function schEnd(){
		$('#leftSearchBx').animate({left:'+=306px'},200);
		$('#searchToggle img').attr('src','/images/renewal2/toggle_in.png');
		$('#searchToggle img').attr('alt','닫기');
	}
	
	/**
	 * 2014.10.27 주제도 관련 추가
	 * kyr
	 */
	function schStartTm(){
		$('#leftSearchBx2').animate({left:'-=237px'},200);
		$('#searchToggleTm img').attr('src','/gis/images/toggle_out.png');
		$('#searchToggleTm img').attr('alt','열기');
		}
		function schEndTm(){
			$('#leftSearchBx2').animate({left:'+=237px'},200);
			$('#searchToggleTm img').attr('src','/gis/images/toggle_in.png');
			$('#searchToggleTm img').attr('alt','닫기');
		}

	// C-1. left result collapsible 기능 함수
	//------------------------------------------------------------------------------------------
	function resultStart(){
		btToggle_flag = true;
		$('#search_result').animate({bottom:'-=239px'},200);
		$('#resultToggle img').attr('src','/images/renewal2/toggle_bout.png');
		$('#resultToggle img').attr('alt','열기');
	}
	function resultEnd(){
		//2014.10.27 kyr 
		//에러 수정 btToggle_flag = true; -> btToggle_flag = false;
		btToggle_flag = false;
		$('#search_result').animate({bottom:'+=239px'},200);
		$('#resultToggle img').attr('src','/images/renewal2/toggle_bin.png');
		$('#resultToggle img').attr('alt','닫기');
	}

	// D-1. left 자동/수동 collapsible 기능 함수
	//------------------------------------------------------------------------------------------
	function autobtStart(){
	//	$('#btTab').animate({right:'-=124px'},200);
	$('#btTab').animate({right:'-=142px'},200);
	$('#btTabToggle img').attr('src','/gis/images/toggle_rout.png');
	$('#btTabToggle img').attr('alt','열기');
	}
	function autobtEnd(){
//		$('#btTab').animate({right:'+=124px'},200);
		$('#btTab').animate({right:'+=142px'},200);
		$('#btTabToggle img').attr('src','/gis/images/toggle_rin.png');
		$('#btTabToggle img').attr('alt','닫기');
	}

	// F-1. right collapsible 기능 함수
	//------------------------------------------------------------------------------------------
	function rStart(){
		$('#rightBx').animate({right:'-=326px'},200);
		$('#rightToggle img').attr('src','/gis/images/toggle_rout.png');
		$('#rightToggle img').attr('alt','열기');
	}
	function rEnd(){
		$('#rightBx').animate({right:'+=326px'},200);
		$('#rightToggle img').attr('src','/gis/images/toggle_rin.png');
		$('#rightToggle img').attr('alt','닫기');
	}
	// H-1. bottom collapsible 기능 함수
	//------------------------------------------------------------------------------------------
	function bStart(){
	$('#bottomBx').animate({bottom:'-=207px'},200);
	$('#btToggle img').attr('src','/gis/images/toggle_bout.png');
	$('#btToggle img').attr('alt','열기');
	}
	function bEnd(){
		$('#bottomBx').animate({bottom:'+=207px'},200);
		$('#btToggle img').attr('src','/gis/images/toggle_bin.png');
		$('#btToggle img').attr('alt','닫기');
	}

	// J-1. top collapsible 기능 함수
	//------------------------------------------------------------------------------------------
	function tStart(){
	$('#topBx').animate({top:'-=130px'},200);
	$('#tpToggle img').attr('src','/gis/images/toggle_tout.png');	
	$('#tpToggle img').attr('alt','열기');
	}
	function tEnd(){
		$('#topBx').animate({top:'+=130px'},200);
		$('#tpToggle img').attr('src','/gis/images/toggle_tin.png');
		$('#tpToggle img').attr('alt','닫기');
	}
})(jQuery);