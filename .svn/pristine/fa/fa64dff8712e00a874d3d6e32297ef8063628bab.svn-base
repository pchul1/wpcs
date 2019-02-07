<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<script type="text/javascript">
//<![CDATA[
	//document.getElementById('IEhackInnerHeight').style.top = (document.getElementById('IEhackInnerHeight').offsetTop)+'px';	
	/* if(window.innerHeight)
		winHeight = window.innerHeight-1;
	else
		winHeight = document.getElementById('IEhackInnerHeight').offsetTop;  */
	
	//var PopupWin3oldonloadHndlr=window.onload;
	var PopupWin3popupHgt, PopupWin3actualHgt, PopupWin3tmrId=-1, PopupWin3resetTimer;
	var PopupWin3titHgt, PopupWin3cntDelta, PopupWin3tmrHide=-1, PopupWin3hideAfter=5000, PopupWin3hideAlpha, PopupWin3hasFilters=true;
	var PopupWin3nWin, PopupWin3showBy=null, PopupWin3dxTimer=-1, PopupWin3popupBottom, PopupWin3oldLeft;
	var PopupWin3nText,PopupWin3nMsg,PopupWin3nTitle,PopupWin3bChangeTexts=false;
// 	window.onload=PopupWin3espopup_winLoad; 
	
	var winHeight = 0;
	
	function PopupWin3espopup_winScroll(){
		var scrollTop = 0;
		
		if(window.innerHeight)
		{
			winHeight = window.innerHeight-1;
			scrollTop = document.body.scrollTop;
		}else{
			scrollTop = document.documentElement.scrollTop;
			winHeight = document.getElementById('IEhackInnerHeight').offsetTop;
		}
		
		el=document.getElementById('PopupWin3');
		el.style.top=(scrollTop + winHeight-110)+'px';
		
		if (PopupWin3tmrHide!=-1){
			el.style.display='none'; 
			el.style.display='block';
		}
	}
	
	function PopupWin3espopup_ShowPopup(show){
		var scrollTop = 0;
		
		if(window.innerHeight)
		{
			winHeight = window.innerHeight-1;
			scrollTop = document.body.scrollTop;
		}else{
			scrollTop = document.documentElement.scrollTop;
			winHeight = document.getElementById('IEhackInnerHeight').offsetTop; 
		}
		
		if (PopupWin3dxTimer!=-1) { el.filters.blendTrans.stop(); }
		
		if ((PopupWin3tmrHide!=-1) && ((show!=null) && (show==PopupWin3showBy))){
			clearInterval(PopupWin3tmrHide);
			PopupWin3tmrHide=setInterval(PopupWin3espopup_tmrHideTimer,PopupWin3hideAfter);
			return;
		}
		
		if (PopupWin3tmrId!=-1) return;
		
		PopupWin3showBy=show;
		
		elCnt=document.getElementById('PopupWin3_content')
		elTit=document.getElementById('PopupWin3_header');
		el=document.getElementById('PopupWin3');
		el.style.left=PopupWin3oldLeft;
		el.style.top=(scrollTop + winHeight-110)+'px';
		el.style.filter='';
		
		if (PopupWin3tmrHide!=-1) clearInterval(PopupWin3tmrHide); PopupWin3tmrHide=-1;
	
		document.getElementById('PopupWin3_header').style.display='none';
		document.getElementById('PopupWin3_content').style.display='none';
		
		if (navigator.userAgent.indexOf('Opera')!=-1)
			el.style.bottom=(document.body.scrollHeight*1-document.body.scrollTop*1
								 -document.body.offsetHeight*1+1*PopupWin3popupBottom)+'px';
		
		if (PopupWin3bChangeTexts){
			PopupWin3bChangeTexts=false;
			document.getElementById('PopupWin3aCnt').innerHTML=PopupWin3nMsg;
			document.getElementById('PopupWin3titleEl').innerHTML=PopupWin3nTitle;
		}
		
		PopupWin3actualHgt=0; el.style.height=PopupWin3actualHgt+'px';
		el.style.visibility='';
		
		if (!PopupWin3resetTimer) el.style.display='';
		
		PopupWin3tmrId=setInterval(PopupWin3espopup_tmrTimer,(PopupWin3resetTimer?2000:20));
	}
	
	function PopupWin3espopup_winLoad(){
		$("#PopupWin3_content").css("display","block");
	}
	
	function PopupWin3espopup_tmrTimer(){
		el=document.getElementById('PopupWin3');
	
		if (PopupWin3resetTimer){
			el.style.display='';
			clearInterval(PopupWin3tmrId); PopupWin3resetTimer=false;
			PopupWin3tmrId=setInterval(PopupWin3espopup_tmrTimer,20);
		}
		
		PopupWin3actualHgt+=5;
		
		if (PopupWin3actualHgt>=PopupWin3popupHgt){
			PopupWin3actualHgt=PopupWin3popupHgt; clearInterval(PopupWin3tmrId); PopupWin3tmrId=-1;
			document.getElementById('PopupWin3_content').style.display='';
			if (PopupWin3hideAfter!=-1) PopupWin3tmrHide=setInterval(PopupWin3espopup_tmrHideTimer,PopupWin3hideAfter);
		}
		if (PopupWin3titHgt<PopupWin3actualHgt-6)
			document.getElementById('PopupWin3_header').style.display='';
		
		if ((PopupWin3actualHgt-PopupWin3cntDelta)>0){
			elCnt=document.getElementById('PopupWin3_content')
			elCnt.style.display='';
			elCnt.style.height=(PopupWin3actualHgt-PopupWin3cntDelta)+'px';
		}
		
		el.style.height=PopupWin3actualHgt+'px';
	}
	
	function PopupWin3espopup_tmrHideTimer(){
		/*
	 clearInterval(PopupWin3tmrHide); PopupWin3tmrHide=-1;
	 el=document.getElementById('PopupWin3');
	 if (PopupWin3hasFilters)
	 {
		backCnt=document.getElementById('PopupWin3_content').innerHTML;
		backTit=document.getElementById('PopupWin3_header').innerHTML;
		document.getElementById('PopupWin3_content').innerHTML='';
		document.getElementById('PopupWin3_header').innerHTML='';
		el.style.filter='blendTrans(duration=1)';
		el.filters.blendTrans.apply();
		el.style.visibility='hidden';
		el.filters.blendTrans.play();
		document.getElementById('PopupWin3_content').innerHTML=backCnt;
		document.getElementById('PopupWin3_header').innerHTML=backTit;
		
		PopupWin3dxTimer=setInterval(PopupWin3espopup_dxTimer,1000);
	 }
	 else el.style.visibility='hidden';
	 */
	}
	
	function PopupWin3espopup_dxTimer(){
		clearInterval(PopupWin3dxTimer); PopupWin3dxTimer=-1;
	}
	
	function PopupWin3espopup_Close(){
		
		if (PopupWin3tmrId==-1){
			el=document.getElementById('PopupWin3');
			el.style.filter='';
			el.style.display='none';
			
			if (PopupWin3tmrHide!=-1) clearInterval(PopupWin3tmrHide); PopupWin3tmrHide=-1;
		}
	}
	
	function PopupWin3espopup_ShowWindow(){
	
		if (PopupWin3nWin!=null) PopupWin3nWin.close();
		
		PopupWin3nWin=window.open('','PopupWin3nWin','width=400,height=250,scrollbars=yes, '+
			'menubar=no, resizable=no, status=no, toolbar=no, location=no');
		PopupWin3nWin.document.write(PopupWin3nText);
	}
	
	var PopupWin3mousemoveBack,PopupWin3mouseupBack;
	var PopupWin3ofsX,PopupWin3ofsY;
		
	function PopupWin3espopup_DragDrop(e){
		PopupWin3mousemoveBack=document.body.onmousemove;
		PopupWin3mouseupBack=document.body.onmouseup;
		ox=(e.offsetX==null)?e.layerX:e.offsetX;
		oy=(e.offsetY==null)?e.layerY:e.offsetY;
		PopupWin3ofsX=ox; PopupWin3ofsY=oy;
		
		document.body.onmousemove=PopupWin3espopup_DragDropMove;
		document.body.onmouseup=PopupWin3espopup_DragDropStop;
		
		if (PopupWin3tmrHide!=-1) clearInterval(PopupWin3tmrHide);
	}
	
	function PopupWin3espopup_DragDropMove(e){
	el=document.getElementById('PopupWin3');
		if (e==null&&event!=null){
			el.style.left=(event.clientX*1+document.body.scrollLeft-PopupWin3ofsX)+'px';
			el.style.top=(event.clientY*1+document.body.scrollTop-PopupWin3ofsY)+'px';
			event.cancelBubble=true;
		}else{
			el.style.left=(e.pageX*1-PopupWin3ofsX)+'px';
			el.style.top=(e.pageY*1-PopupWin3ofsY)+'px';
			e.cancelBubble=true;
		}
		
		if ((event.button&1)==0) PopupWin3espopup_DragDropStop();
	}
	
	function PopupWin3espopup_DragDropStop()
	{
		document.body.onmousemove=PopupWin3mousemoveBack;
		document.body.onmouseup=PopupWin3mouseupBack;
	}
	
	// 경고메세지 띄우는 작업 
	// 기능 삭제 2014-10-31 kys
	function getRecentAlertData()
	{
		var url = "";
		$.ajax({
			type:"GET",
			url:"<c:url value='/alert/getNewWarring.do'/>",
			dataType:"json",
			success:function(result){
				
				var obj = result['data'];
				
				if(obj != null && obj.alertTime != null)
				{
					
					var msg = "<img src='/gis/images/event50.gif' border='0'><b>[ 사고발생 ]</b><br/><br/>" +
							  "<b> [ 일시 :	" + obj.alertTime + " ]</b><br/>" + 
							  "&nbsp;<b>-수계 : " + obj.riverDiv + "</b><br/>" +
							  "&nbsp;<b>-유형 : " + obj.receiptType + "</b><br/>";
									
					$("#popContent").html(msg);
					
					url = "/waterpollution/waterPollutionDetail.do?wpCode=" + obj.wpCode; 
					$("#PopupWin3_ahref").attr("onclick","goMenu('"+url+"','32120');return false;");
					PopupWin3espopup_winLoad();
				}
				else
				{
					//alert("null");
				}
				
			},
			error:function(result){	
				//alert("error");
			}
		});
		
		cd();
	}
/* 알림기능 제거 2016-11-19
	$(function(){
		cd();
	});
*/
	function cd()
	{
		setTimeout(getRecentAlertData, 1000 * 60 );
	}

	// 윈도우 리사이즈시 호출됨.
		/* jQuery(window).scroll(function(){
			PopupWin3espopup_winScroll();
		}); */
//]]>
</script>

<script type="text/javascript">
	function linkChanged(){
		document.location.href = document.getElementById("family_menu").value;
	}
</script>

<script type="text/javascript">
	$(document).ready(function(){
		$('#footer_toggle_btn').toggle(footerShow, footerHide);
// 		$('#footer_toggle_btn').click();
	});
	function footerHide(){
		$("#footer_toggle_btn").attr("src","<c:url value='/images/gis/toggle_bout.png'/>");
		$("#footer").animate({bottom:'-70px'},200);
		type = "out";
		resize();
	}
	function footerShow(){
		$("#footer_toggle_btn").attr("src","<c:url value='/images/gis/toggle_bin.png'/>");
		$("#footer").animate({bottom:'0'},200);
		type = "in";
		resize();
// 		var myTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
// 		$("body, html").animate({scrollTop : myTop+70}, 500);
	}
</script>

	<div class="footerToggleDiv">
		<img id="footer_toggle_btn" src="<c:url value='/images/gis/toggle_bout.png'/>"  alt="footer_toggle_btn" />
	</div>
	<div id="footer_content" style="z-index: 100">
		<div id="copy_ci"></div>

		<div id="copy_family">
			<select id="family_menu" name="family_menu" class="copy_family" onchange="javascript:linkChanged();" title="관련기관">
				<option value="">바로가기</option>
				<option value="http://www.me.go.kr">환경부</option>
				<option value="http://www.me.go.kr/hg/">한강유역환경청</option>
				<option value="http://www.me.go.kr/gg/">금강유역환경청</option>
				<option value="http://www.me.go.kr/ysg/">영산강유역환경청</option>
				<option value="http://www.nier.go.kr">국립환경과학원</option>
				<option value="http://www.hrfco.go.kr/">한강홍수통제소</option>
			</select>
		</div>

		<div id="copy_address_field" style="z-index: 100">
			<!-- <div id="copy_address">대구광역시 수성구 지산1동 무학로 209 TEL : 1666-0128, FAX : 053-766-9186</div> -->
			<div id="copy_address">인천광역시 서구 환경로 42 (경서동 종합환경연구단지) TEL : 032 - 590 - 3904, 3901 ~ 3911 , FAX :  032 - 590 - 3919</div>
			<div id="copy_copy">COPYRIGHT(C) 2014 Korea Environment Coporation All Rights Reserved</div>
		</div>
		
	</div>
	
	<div id="PopupWin3" style="display:none; background:#E0E9F8; border-right:1px solid #455690;
								border-bottom:1px solid #455690; border-left:1px solid #B9C9EF; border-top:1px solid #B9C9EF; position:absolute;
								z-index:9999; width:200px; height:100px; right:15px; bottom:15px;"
								onselectstart="return false;">
	</div>
	<div id="PopupWin3_header" style="cursor:default; display:none; position:absolute; left:2px; width:196px; 
												top:2px; height:16px;
												filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FFE0E9F8', EndColorStr='#FFFFFFFF');
												font:12px arial,sans-serif; color:#1F336B; text-decoration:none;">
		<span id="PopupWin3titleEl">수질오염 상황접수</span>
		<span style="position:absolute; right:0px; top:0px; cursor:pointer; color:#728EB8; font:bold 12px arial,sans-serif; 
						 position:absolute; right:3px;"
				onclick="PopupWin3espopup_Close()"
				onmousedown="event.cancelBubble=true;"
				onmouseover="style.color='#455690';"
				onmouseout="style.color='#728EB8';">X</span>
	</div>
	<div id="PopupWin3_content" style="display:none;border-left:3px solid red; border-top:3px solid red;
										border-bottom:3px solid red; border-right:3px solid red;
										background:#E0E9F8; padding:2px; overflow:hidden; text-align:left;
										filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FFE0E9F8', EndColorStr='#FFFFFFFF');
										position:absolute; left:2px; width:190px; top:-130px; height:117px;">
		<a style="font:12px arial,sans-serif; color:#1F336B; text-decoration:none;" 
			onmouseover="style.textDecoration='underline';"
			onmousedown="event.cancelBubble=true;" 
			onmouseout="style.textDecoration='none';"
			href="#" target="" id="PopupWin3_ahref"><span id="popContent"></span></a>
	</div>