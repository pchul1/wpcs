<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%@ taglib prefix="pj" uri="ProjectJstlUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>
<!-- <link rel="stylesheet" href="http://js.arcgis.com/3.8/js/dojo/dijit/themes/claro/claro.css"/> -->
<!-- <link rel="stylesheet" href="http://js.arcgis.com/3.8/js/esri/css/esri.css"/> -->
<link rel="stylesheet" type="text/css" href="/css/common.css"/>
<link rel="stylesheet" type="text/css" href="/gis/css/gis.css"/>

<!-- <link rel="stylesheet" type="text/css" href="http://mleibman.github.io/SlickGrid/slick.grid.css"/> -->
<link rel="stylesheet" type="text/css" href="/slickgrid/css/slick.grid.css"/>

<link rel="stylesheet" type="text/css" href="/js/JQuery/css/ui.all.css" />
<link rel="stylesheet" type="text/css" href="/css/common.css"/>
<link rel="stylesheet" type="text/css" href="/css/site.css"/>

<!-- <link rel="stylesheet" type="text/css" href="http://mleibman.github.io/SlickGrid/examples/slick-default-theme.css"/> -->

<title>수질오염 방제정보 시스템</title>
<%-- <c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" /> --%>

<%
String user_id = (String) request.getSession().getAttribute("userId");
String sessionId = request.getSession().getId();
//response.setHeader("SET-COOKIE", "JSESSIONID=" + sessionId + "; HttpOnly;");

/* Cookie cookie = new Cookie("UID", user_id); // 쿠키를 세팅한다
cookie.setPath("/");
response.addCookie(cookie); */
%>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="/js/organictabs.jquery.js"></script>
<script type="text/javascript" src="/js/UI.js"></script>

<!-- <script type="text/javascript" src="/gis/gis/jsapi_vsdoc10_v36.js"></script> -->
<script type="text/javascript" src="/gis/js/jquery.dialog.custom.js"></script>

<script src="/gis/js/xml2json.js"></script>
<!-- <script src="http://js.arcgis.com/3.8/"></script> -->

<script type="text/javascript" src="/slickgrid/js/jquery.event.drag-2.2.js"></script>
<script type="text/javascript" src="/slickgrid/js/slick.core.js"></script>
<!-- <script type="text/javascript" src="http://mleibman.github.io/SlickGrid/slick.grid.js"></script> -->
<script type="text/javascript" src="/slickgrid/js/slick.grid_2.2.2.js"></script>
<script type="text/javascript" src="/slickgrid/js/slick.dataview.js"></script>
<script type="text/javascript" src="/slickgrid/js/slick.rowselectionmodel.js"></script>
<script src="/js/common.js"></script>

<script src="/js/menu.js"></script>

<script src="/gis/js/rolling.js"></script>
<!-- <script src="/gis/js/acco.js"></script> -->
<script src="/gis/js/define.js"></script>
<script src="/gis/js/common.js"></script>
<script src="/gis/js/new_main.js"></script>
<script src="/gis/js/new_kecoMap.js"></script>


<script type="text/javascript" src="/gis/new_js/lib/proj4.js" ></script>
<script type="text/javascript" src="/gis/new_js/lib/mapEventBus.js" ></script>
<!-- <script type="text/javascript" src="/gis/new_js/lib/ol/ol.js"></script> -->
<script type="text/javascript" src="http://tsauerwein.github.io/ol3/mapbox-gl-js/build/ol.js"></script>
 
<script type="text/javascript" src="/gis/new_js/lib/jsts/jsts.min.js"></script>

<script type="text/javascript" src="/gis/new_js/mapService.js"></script>
<script type="text/javascript" src="/gis/new_js/lib/vworldLayer.js"></script>
<script type="text/javascript" src="/gis/new_js/lib/coreMap.js"></script>
<script type="text/javascript" src="/gis/new_js/lib/jquery-ui.js"></script>

<!-- <script src="/gis/js/kecoMap.js"></script> -->
<!-- <script src="/gis/js/CustomPrintTask.js"></script> -->


<style>
      .tooltip {
        position: relative;
        background: rgba(0, 0, 0, 0.5);
        border-radius: 4px;
        color: white;
        padding: 4px 8px;
        opacity: 0.7;
        white-space: nowrap;
      }
      .tooltip-measure {
        opacity: 1;
        font-weight: bold;
      }
      .tooltip-static {
        background-color: #ffcc33;
        color: black;
        border: 1px solid white;
      }
      .tooltip-measure:before,
      .tooltip-static:before {
        border-top: 6px solid rgba(0, 0, 0, 0.5);
        border-right: 6px solid transparent;
        border-left: 6px solid transparent;
        content: "";
        position: absolute;
        bottom: -6px;
        margin-left: -7px;
        left: 50%;
      }
      .tooltip-static:before {
        border-top-color: #ffcc33;
      } 
      .tempTooltip {
		  position: relative;
		  padding: 3px;
		  background: rgba(0, 0, 0, 0.5);
		  color: white;
		  opacity: 0.7;
		  white-space: nowrap;
		  font: 10pt sans-serif;
		}
   
</style>
      
<script type="text/javascript">
//<![CDATA[
	$(function () {
		
		var dailyWorkAppCheck = '${dailyWorkAppCheck}';

		if(dailyWorkAppCheck=='Y'){
			layerPopOpen('layerApprovalIns');
		}
		
		_CoreMap.init('map',{
			satellite: true,
			measure:true,
			print:true,
			save:true,
			search:true,
			temp:true
		});
	});
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
// 		layerPopClose("layerGroupIns");
// 		layerPopClose("layerGroupDel");
	}
	
	function approvalCheck(){
		var link = "/dailywork/receiveApprovalList.do";
		var menuId = "33200";
// 		location.href = "<c:url value='/dailywork/receiveApprovalList.do'/>";
		goMenu(link,menuId);
	}
//]]>

	function tabChange(sel){
		$("#mainTab li").removeClass("on");
		if(sel == 'm1'){
			$("#main_div_m2").hide();
			$("#main_div_m1").show();
			$(".control .play").click();
		}else if(sel == 'm2'){
			$(".control .stop").click();
			var width = $("#main_div_m1").width();
			var height = $("#main_div_m1").height();
			$("#main_div_m1").hide();
			$("#main_div_m2").show();
			$("#main_div_m2").attr("height",height);
			$("#ifrm").attr("width",width);
			
			document.frm.target="ifrm";
			document.frm.action="/waterpolmnt/situationctl/goTotalMntMainTS.do";
			document.frm.submit();
		}
		$("#mainTab li."+sel).addClass("on");
	}
	
	function selectWaterPop(str) {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 557;		
		var winWidth = 960;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = 50;
		//var winTopPost = (sh - winHeight) /2;
		var width = winWidth-20;
		var height = winHeight-20;
		
		var pointVal = str;		
		//var pointVal = "!IP-USN,99U1001,15.IP-USN,99U1001,16.IP-USN,99U1001,17.IP-USN,99U1001,18.IP-USN,99U1001,19";
		//var pointVal = "!국가수질자동측정망,S02001,1.국가수질자동측정망,S02002,1.국가수질자동측정망,S02003,1.국가수질자동측정망,S02004,1.국가수질자동측정망,S02009,1.국가수질자동측정망,S02015,1.국가수질자동측정망,S02019,1";
		var sysTemp = pointVal.split(",");
		var sys = sysTemp[0];
		if(sys=="이동형측정기기" || sys=="!이동형측정기기" ){
			sys = "U";
		}
		else if(sys=="국가수질자동측정망" || sys=="!국가수질자동측정망" ){
			sys = "A";
		}
		/* else if(sys=="수질TMS"){
			sys = "W";
		}
		else if(sys=="탁수 모니터링"){
			sys = "T";
		} */
		else 
		{
			sys="";
		}
		
		var valTemp = pointVal.split(".");
		var val;
		for(var i=0; i<valTemp.length; i++){
			chkTemp = valTemp[i].split(",");
			chk = chkTemp[0];
			if(chk=="이동형측정기기" || chk=="!이동형측정기기" ){
				pointVal = pointVal.replace("이동형측정기기", "U");
			}
			else if(chk=="국가수질자동측정망" || chk=="!국가수질자동측정망" ){
				pointVal = pointVal.replace("국가수질자동측정망", "A");
			}
		}
		
		window.open("<c:url value='/waterpolmnt/situationctl/goSelectWATERSYSMNT.do?'/>sys="+sys+"&pointVal="+pointVal,// 
				'GisView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function selectAllWaterPop(str) { 
		//alert("str : " + str);
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 350;
		var winWidth = 1190;
		//var winWidth = 1000;
		var winLeftPost = (sw - winWidth) / 2;var winTopPost = 50;
		var width = winWidth-20;
		var height = winHeight-20;
		
		var pointVal = str;
		//var pointVal = "!IPUSN,99U1001,15.IPUSN,99U1001,16.IPUSN,99U1001,17.IPUSN,99U1001,18.IPUSN,99U1001,19.보,2014802.보,2014802.";
		//var pointVal = "보,2014802.보,2014801.수질TMS,47A0341,1.수질TMS,47A0061,1.IPUSN,99U1001,16.IPUSN,99U1001,17.국가수질자동측정망,S02002,1.국가수질자동측정망,S02003,1.댐,1012110.댐,1004310.!방제창고,WH0111740005.방제창고,WH0111290007.";
		//var pointVal = "!국가수질자동측정망,S02001,1.국가수질자동측정망,S02002,1.국가수질자동측정망,S02003,1.국가수질자동측정망,S02004,1.국가수질자동측정망,S02009,1.국가수질자동측정망,S02015,1.국가수질자동측정망,S02019,1";
				
		var valTemp = pointVal.split(".");
		var sys = "";
		for(var i=0; i<valTemp.length; i++){
			chkTemp = valTemp[i].split(",");
			chk = chkTemp[0];
			
			if(chk=="이동형측정기기" || chk=="!이동형측정기기" ){
				pointVal = pointVal.replace(/\이동형측정기기/gi, "U");
				
				if(chk.indexOf("!") > -1){
					sys = "U";
				}
			}
			else if(chk=="국가수질자동측정망" || chk=="!국가수질자동측정망" ){
				pointVal = pointVal.replace(/\국가수질자동측정망/gi, "A");
				
				if(chk.indexOf("!") > -1){
					sys = "A";
				}
			}
			else if(chk=="수질TMS" || chk=="!수질TMS" ){
				pointVal = pointVal.replace(/\수질TMS/gi, "W");
				
				if(chk.indexOf("!") > -1){
					sys = "W";
				}
			}
			else if(chk=="방제창고" || chk=="!방제창고" ){
				pointVal = pointVal.replace(/\방제창고/gi, "P");
				
				if(chk.indexOf("!") > -1){
					sys = "P";
				}
			}
			else if(chk=="댐" || chk=="!댐" ){
				pointVal = pointVal.replace(/\댐/gi, "D");
				
				if(chk.indexOf("!") > -1){
					sys = "D";
				}
			}
			else if(chk=="보" || chk=="!보" ){
				pointVal = pointVal.replace(/\보/gi, "I");
				
				if(chk.indexOf("!") > -1){
					sys = "I";
				}
			}
		}
		
		window.open("<c:url value='/waterpolmnt/situationctl/goSelectAllWATERSYSMNT.do?'/>sys="+sys+"&pointVal="+pointVal,// 
				'GisMultiView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	function fn_moveWH(){
		location.href="<c:url value='/warehouse/wareHouseList.do'/>";
	}
</script>


<style>
/* #map table td img{vertical-align:baseline;} */
#map table {}
#map table tr {}
#map table td {}
#map table td img{}
img{}
/* table td img{vertical-align:super;} */

</style>
</head>

<body>
	<div id='loadingDiv' style="visibility:hidden;position:absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="wrap">
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->
<!-- 		<ul> -->
<!-- 			<li><input type="button" onclick="$kecoMap.model.daum()" value="다음" /></li> -->
<!-- 			<li><input type="button" onclick="$kecoMap.model.eventTest()" value="사고" /></li> -->
<!-- 			<li><div id="slider" style="width:200px;"></div></li> -->
<!-- 		</ul> -->
		<!-- Body Start-->
		<div id="mainTab">
			<ul>
				<li class="li_space" style="width:20px;"></li>
				<li class="m1 on" onclick="javascript:tabChange('m1');"></li>
				<li class="li_space"></li>
				<c:if test="${!empty TotalMntMainTS }">
				<li class="m2" onclick="javascript:tabChange('m2');"></li>
				</c:if>
				<li style="float: right;width: auto; margin-right:30px;">
					<div style="float:left;width:65px;border-color: #b7b7b7 #b7b7b7 #747474; border-style: solid ; border-width: 0; height:32px; text-align: center;font-weight: bold;font-size: 13px;color:red;">사고현황</div>
					<div style="float:left;width:200px;border-color: #b7b7b7 #b7b7b7 #747474; border-style: solid ; border-width: 0; height:32px; text-align: center;">
						<select id="wateryear" onchange="$main.model.getWaterPollutionStatus();">
							<c:forEach begin="10" end="${fn:substring(pj:toDay('yyyy'),2,4)}" var="i" step="1">
								<option value='20<c:out value="${i}"/>' <c:if test="${fn:substring(pj:toDay('yyyy'),2,4) eq i}">selected="selected"</c:if>>20<c:out value="${i}"/></option>
							</c:forEach>
						</select>년
						
						<c:set var="cnt" value="1"/>
						<select id="watermonth" onchange="$main.model.getWaterPollutionStatus();">
							<c:forEach begin="1" end="12" var="i" step="1">
								<c:set var="cnt" value="${i}"/>
								<c:if test="${i < 10}"><c:set var="cnt" value="0${i}"/></c:if>
								<option value='<c:out value="${cnt}"/>' <c:if test="${pj:toDay('MM') eq cnt}">selected="selected"</c:if>><c:out value="${cnt}"/></option>
							</c:forEach>
						</select>월
						
						<c:set var="cnt" value="1"/>
						<select id="waterday" onchange="$main.model.getWaterPollutionStatus();">
							<c:forEach begin="1" end="31" var="i" step="1">
								<c:set var="cnt" value="${i}"/>
								<c:if test="${i < 10}"><c:set var="cnt" value="0${i}"/></c:if>
								<option value='<c:out value="${cnt}"/>' <c:if test="${pj:toDay('dd') eq cnt}">selected="selected"</c:if>><c:out value="${cnt}"/></option>
							</c:forEach>
						</select>일
					</div>
					<div style="float:left;width:300px;border-color: #b7b7b7 #b7b7b7 #747474; border-style: solid ; border-width: 0; height:32px; text-align: center;" id="waterContent"></div>
					<div style="float:left;width:80px;border-color: #b7b7b7 #b7b7b7 #747474; border-style: solid ; border-width: 0; height:32px; text-align: center;cursor: pointer;" id="waterListButton" onclick="$main.model.getWaterPollutionStatusdisplay();">펼쳐보기 ▼</div>
				</li>
			</ul>
		</div>
		<div style="background-color:white;width:700px;position: absolute;z-index:9999;right:30px;border:3px solid #07AFFA;padding:15px;display:none;" id="waterListTable">
			<div style="position:abolute;padding:0 10px 10px;float:right;font-size:20px;"><a onclick="$main.model.getWaterPollutionStatusdisplay();" style="cursor: pointer;">X</a></div>
			<table summary="알림 목록. 구분, 알림날짜, 알림내용, 확인이 담김" style="width:700px;">
				<colgroup>
					<col width="100" />
					<col width="100" />
					<col width="100" />
					<col width="100" />
					<col width="100" />
					<col width="100" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col" rowspan="2">구분</th>
						<th scope="col" rowspan="2">신고</th>
						<th scope="col" rowspan="2">접수</th>
						<th scope="col" rowspan="2">수습중</th>
						<th scope="col" colspan="2">조치완료</th>
					</tr>
					<tr>
						<th scope="col">접수</th>
						<th scope="col">지원</th>
					</tr>
				</thead>
				<tbody id="waterlistContent">
				</tbody>
			</table>
		</div>
		<!-- notice 리스트 클릭시 레이어팝업 표출 --> 
		<div style="overflow:scroll;background-color:white;width:950px;height: 500px;position: absolute;z-index:9999;right:15px;top:177px;border:3px solid #07AFFA;padding:15px;display:none;" id="alertListTable">
			<div style="position:abolute;padding:0 10px 10px;float:right;font-size:20px;"><a onclick="$main.model.getAlertListStatusdisplay();" style="cursor: pointer;">X</a></div>
			<table summary="시스템, 수신시간, 단계, 수계, 경보내용이 담김" style="width:930px;">
				<colgroup>
					<col width="120" />
					<col width="140" />
					<col width="50" />
					<col width="50" />
					<col width="80" />
					<col width="50" />
					<col width="50" />					
					<col width="*" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col" >시스템</th>
						<th scope="col" >수신시간</th>
						<th scope="col" >단계</th>
						<th scope="col" >수계</th>
						<th scope="col" >측정소</th>
						<th scope="col" >측정값</th>
						<th scope="col" >기준치</th>
						<th scope="col" >경보내용</th>
					</tr>				
				</thead>
				<tbody id="alertlistContent">
				</tbody>
			</table>
		</div>
		 
		
		<!-- 4대강 유역 사고 발생 모니터링 영역 -->
		<div id="main_div_m1">
			<div id="topInfo">
				<div id="notice5" class="news">
					<div class="open-event fl">
						<ul class="notice-list" id="rolling" onclick="$main.model.getAlertListStatusdisplay();"></ul> 
						<div style="float:right">
							<div class="control fl" style="float:right">
								<a title="재생" class="play" href="#">재생활성</a>
								<a title="정지" class="stop" href="#">정지비활성</a>
							</div>
							<div id="bt5" style="float:right;padding-top:12px">
								<a title="이전" class="prev" href="#"><img alt="이전" src="/gis/images/notice_pre.gif"/></a>
								<a title="다음" class="next" href="#"><img alt="다음" src="/gis/images/notice_next.gif"/></a>
							</div> 
						</div>
					</div>
					<script type="text/javascript">fn_article3('notice5', 'bt5', true);</script>
					</div>
	<!--			<div class="totalNotice"><a href="javascript:fn_popup('/bbs/selectBoardArticle.do?bbsId=BBSMSTR_000000000030&viewFlag=popup')">공지사항</a></div> -->
				<div class="wareHouse"><a href="javascript:fn_moveWH()">방제물품</a></div>
				<div class="totalNotice"><a href="javascript:fn_popup('/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000030&viewFlag=popup')">공지사항</a></div>
			</div>
			<div id="mapBox">
				<div id="map" class="claro" >
					<div id="search_result">
						<div id="slickNullSearch" class="slickNullSearch" style="left:320px; top:140px;">조회 결과가 없습니다.</div>
						<div id="resultToggle"><img src="/images/renewal2/toggle_bin.png" alt="닫기"/></div>
						<div id="resultBtArea"><input type="button" id="excelDnBtn" value="엑셀" class="bt_xls"/></div>
						<div id="result">
							
							<div id="resultDiv" class="table_info" style="height: 100%">
							</div>
							
						</div>
					</div>
				</div>
<!-- 				<div id="mapInfo"><img src="/gis/images/navi_icon.png" alt=""/>4대강 유역 사고 발생 모니터링</div> -->
				<!--우측 상단 버튼 Start-->
<!-- 				<div id="tool" style="width: 630px;"> -->
<!-- 					<div class="tool_bu1"><a href="javascript:$kecoMap.model.generalMap();" onmouseout="$kecoMap.controller.MM_swapImgRestore('Image1','/gis/images/new_tool_1_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image1','/gis/images/new_tool_1_over1.gif',1)" ><img idx="0" src="/gis/images/new_tool_1_over1.gif" id="Image1" width="42" height="30" border="0" /></a></div>
<!-- 					<div class="tool_bu1"><a href="javascript:$kecoMap.model.flightMap();"	onmouseout="$kecoMap.controller.MM_swapImgRestore('Image2','/gis/images/new_tool_2_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image2','/gis/images/new_tool_2_over1.gif',1)" ><img idx="1" src="/gis/images/new_tool_2_off.gif" id="Image2" width="42" height="30" border="0" /></a></div> --> -->
<!-- 					<div class="tool_bu1" style="width:42px;"><a href="javascript:$kecoMap.model.generalMap();" onmouseout="$kecoMap.controller.MM_swapImgRestore('Image1','/gis/images/new_tool_1_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image1','/gis/images/new_tool_1_over1.gif',1)" ><img idx="0" src="/gis/images/new_tool_1_over1.gif" id="Image1" width="42" height="30" border="0" /></a></div> -->
<!-- 					<div class="tool_bu1" style="width:42px;"><a href="javascript:$kecoMap.model.flightMap();"	onmouseout="$kecoMap.controller.MM_swapImgRestore('Image2','/gis/images/new_tool_2_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image2','/gis/images/new_tool_2_over1.gif',1)" ><img idx="1" src="/gis/images/new_tool_2_off.gif" id="Image2" width="42" height="30" border="0" /></a></div> -->
<!-- 					<div class="tool_bu2"><a href="javascript:$kecoMap.model.distances();"	onmouseout="$kecoMap.controller.MM_swapImgRestore('Image3','/gis/images/new_tool_3_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image3','/gis/images/new_tool_3_over.gif',1)" ><img idx="2" src="/gis/images/new_tool_3_off.gif" id="Image3" width="58" height="30" border="0" /></a></div> -->
<!-- 					<div class="tool_bu2"><a href="javascript:$kecoMap.model.area()"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image4','/gis/images/new_tool_4_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image4','/gis/images/new_tool_4_over.gif',1)" ><img idx="3" src="/gis/images/new_tool_4_off.gif" id="Image4" width="58" height="30" border="0" /></a></div> -->
<!-- 					<div class="tool_bu1"><a id="printBtn" href="javascript:void(0)"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image5','/gis/images/tool_5_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image5','/gis/images/tool_5_over.gif',1)" ><img idx="4" src="/gis/images/tool_5_off.gif" id="Image5" width="42" height="30" border="0" /></a></div> -->
<!-- 					<div class="tool_bu1"><a id="saveBtn" href="javascript:void(0)"			onmouseout="$kecoMap.controller.MM_swapImgRestore('Image6','/gis/images/tool_6_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image6','/gis/images/tool_6_over.gif',1)" ><img idx="5" src="/gis/images/tool_6_off.gif" id="Image6" width="42" height="30" border="0" /></a></div> -->
<!-- <!-- 					<div class="tool_bu1"><a href="javascript:void(0)"						onmouseout="$kecoMap.controller.MM_swapImgRestore('Image7','/gis/images/tool_7_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image7','/gis/images/tool_7_over.gif',1)" ><img  idx="6" src="/gis/images/tool_7_off.gif" id="Image7" width="42" height="30" border="0" /></a></div> -->						 -->
<!-- 					<div class="tool_bu3"><a href="javascript:$kecoMap.model.info()"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image9','/gis/images/tool_8_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image9','/gis/images/tool_8_over.gif',1)" ><img idx="7" src="/gis/images/tool_8_off.gif" id="Image9" width="42" height="30" border="0" class="off"/></a></div> -->
<!-- 					<div class="tool_bu3"><a href="javascript:$kecoMap.model.buffer()"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image10','/gis/images/tool_8_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image10','/gis/images/tool_8_over.gif',1)" ><img idx="8" src="/gis/images/tool_8_off.gif" id="Image10" width="42" height="30" border="0"/></a></div>
<!-- 					<div class="tool_bu3"><a href="javascript:$kecoMap.model.buffer_all()"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image11','/gis/images/tool_8_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image11','/gis/images/tool_8_over.gif',1)" ><img idx="9" src="/gis/images/tool_8_off.gif" id="Image11" width="42" height="30" border="0"/></a></div> -->
<!-- 					<div class="tool_bu3"><a href="javascript:$kecoMap.model.buffer_drag()"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image12','/gis/images/tool_8_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image12','/gis/images/tool_8_over.gif',1)" ><img idx="10" src="/gis/images/tool_8_off.gif" id="Image12" width="42" height="30" border="0"/></a></div> --> -->
<!-- 					<div class="tool_bu2"><a href="javascript:$kecoMap.model.buffer()"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image10','/gis/images/new_tool_10_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image10','/gis/images/new_tool_10_over.gif',1)" ><img idx="8" src="/gis/images/new_tool_10_off.gif" id="Image10" width="58" height="30" border="0"/></a></div> -->
<!-- 					<div class="tool_bu2"><a href="javascript:$kecoMap.model.buffer_all()"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image11','/gis/images/new_tool_11_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image11','/gis/images/new_tool_11_over.gif',1)" ><img idx="9" src="/gis/images/new_tool_11_off.gif" id="Image11" width="58" height="30" border="0"/></a></div> -->
<!-- 					<div class="tool_bu2"><a href="javascript:$kecoMap.model.buffer_drag()"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image12','/gis/images/new_tool_12_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image12','/gis/images/new_tool_12_over.gif',1)" ><img idx="10" src="/gis/images/new_tool_12_off.gif" id="Image12" width="58" height="30" border="0"/></a></div> -->
<!-- 					<div class="tool_bu2"><a id="vworldBtn" href="javascript:void(0)"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image13','/gis/images/new_tool_13_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image13','/gis/images/new_tool_13_over.gif',1)" ><img idx="10" src="/gis/images/new_tool_13_off.gif" id="Image13" width="58" height="30" border="0"/></a></div> -->
<!-- 					<div class="tool_bu2"><a id="tempBBtn" href="javascript:void(0)"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image14','/gis/images/new_tool_14_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image14','/gis/images/new_tool_14_over.gif',1)" ><img idx="10" src="/gis/images/new_tool_14_off.gif" id="Image14" width="58" height="30" border="0"/></a></div> -->
<!-- 					<div class="tool_bu3"><a href="javascript:$kecoMap.model.clear()"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image8','/gis/images/new_tool_8_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image8','/gis/images/new_tool_8_over.gif',1)" ><img idx="6" src="/gis/images/new_tool_8_off.gif" id="Image8" width="42" height="30" border="0" /></a></div> -->
<!-- 					<div class="tool_bu3" style="width:50px;"><a href="javascript:$kecoMap.model.clear()"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image8','/gis/images/new_tool_8_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image8','/gis/images/new_tool_8_over.gif',1)" ><img idx="6" src="/gis/images/new_tool_8_off.gif" id="Image8" width="50" height="30" border="0" /></a></div> -->
					
<!-- 					<div id="tool_buffer" style="display:none;"> -->
<!-- 						<ul> -->
<!-- 							<li>&nbsp;&nbsp;반경 &nbsp;<input type="text" id="tool_buffer_txt" value="5" style="width: 50px;"/> &nbsp;km</li> -->
<!-- 						</ul> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<!--우측 상단 버튼 End-->

				<!--좌측 검색패널 Start-->
				<div id="leftSearchBx">
					<div id="leftSearch">
						<div class="top_search">
							<span class="title">경보발령 현황</span>
<!-- 							<input type="button" name="" class="bt_more" value="more" onclick="javascript:admin_popup();"/> -->
							<table summary="" class="table_info">
								<caption>경보발령 현황</caption>
								<colgroup>
								<col width="70" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />																
								</colgroup>
								<thead>
									<tr>
										<th scope="col">구   분</th>
										<th class="black" scope="col">합계</th>
										<th class="green" scope="col">정상</th>
										<th class="blue" scope="col" >관심</th>										
										<th class="yellow" scope="col" >주의</th>										
										<th class="orange" scope="col" >경계</th>										
										<th class="red" scope="col">심각</th>
										<th class="gray" scope="col" class="last">미수신</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>이동형<br/>측정기기</td>
										<td class="black" id="totalu" align="center"></td>
										<td class="green" id="normalu" align="center"></td>
										<td class="blue" id="interestu" align="center" ></td>
										<td class="yellow" id="cautionu" align="center" ></td>
										<td class="orange" id="alertu" align="center" ></td>
										<td class="red" id="overu" align="center"></td>
										<td class="gray" id="norecvu" class="last" align="center"></td>
									</tr>
									<tr>
										<td>국가수질<br/>자동측정망</td>
										<td class="black" id="totala" align="center"></td>
										<td class="green" id="normala" align="center"></td>
										<td class="blue" id="interesta" align="center" ></td>
										<td class="yellow" id="cautiona" align="center" ></td>
										<td class="orange" id="alerta" align="center" ></td>										
										<td class="red" id="overa" align="center"></td>
										<td class="gray" id="norecva" class="last" align="center"></td>
									</tr>	
									<!-- <tr>
										<td class="bigo" id="cntt" rowspan = 2>수질TMS<br/></td>
										<td class="black2" id="totalt" align="center"></td>
										<td class="green2" id="normalt" align="center"></td>
										<td class="blue2" id="interestt" align="center"  ></td>
										<td class="yellow2" id="cautiont" align="center"></td>										
										<td class="red2" id="alertt" align="center" colspan = '2'></td>
										<td class="gray2" id="norecvt" class="last" align="center"></td>
									</tr> -->
										
																		
								</tbody>
							</table>
							<br/>
							<table summary="" class="table_info">
								<caption>경보발령 현황 수질 TMS</caption>
								<colgroup>
								<col width="70" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">구   분</th>
										<th class="black"  align="center">합계</th>
										<th class="green"  align="center">정상</th>
										<th class="blue"  align="center" >주의<br/><font size="1">(70%)</font></th>
										<th class="yellow"  align="center" >경보<br/><font size="1">(90%)</font></th>										
										<th class="red"  align="center" colspan = '2'>초과</th>
										<th class="gray"  class="last" align="center">미수신</th>
									</tr>
								</thead>
								<tbody>							
									
									<tr>
										<td id="cntt">수질TMS<br/></td>
										<td class="black" id="totalt" align="center"></td>
										<td class="green" id="normalt" align="center"></td>
										<td class="blue" id="interestt" align="center"  ></td>
										<td class="yellow" id="cautiont" align="center"></td>										
										<td class="red" id="alertt" align="center" colspan = '2'></td>
										<td class="gray" id="norecvt" class="last" align="center"></td>
									</tr>								
								</tbody>
							</table>
							 
							<div class="divideBx" ></div>
							<div class="searchBoxTab">
								<ul class="nav">
									<li class="nav-one"><a href="#siteCase" class="current">측정소</a></li>
									<!-- <li class="nav-two"><a href="#typeCase">유형별</a></li> -->
								</ul>
							</div>
						</div>
						<div class="list-wrap">
							<div id="siteCase"  class="tabCase">
								<div id="search">
								<script>
								</script>
<!-- 									<span class="title">측정소 검색</span> -->
									<div id="search_terms">
										<ul>
											<li>
												<span class="point">시스템</span>
												<select name="" id="system" style="width:180px">
	<!-- 												<option value="all">전체</option> -->
<!-- 													<option value="U">IP-USN</option> -->
<!-- 													<option value="A">국가수질자동측정망</option> -->
<!-- 													<option value="W">수질TMS</option> -->
												</select>
											</li>
											<li>
												<span class="point">수계</span>
												<select name="" id="sugye" style="width:180px">
												</select>
											</li>
											<li id="noipusnselect">
												<span class="point">지역</span>
												<select name="" id="factCode" style="width:180px">
													<option value="all">전체</option>
												</select>
											</li>
											<li id="ipusnselect">
												<span class="point">측정소</span>
												<select name="" id="branch_no" style="width:180px">
													<option value="all">전체</option>
												</select>
											</li>
											<!-- li>
												<span>측정소</span>
												<select name="" style="width:180px">
													<option>전체</option>
													<option>한강IP-USN</option>
												</select>
											</li>
											<li>
												<span>사고 유형</span>
												<select name="" style="width:180px">
													<option>전체</option>
													<option>유류유출</option>
													<option>물고기폐사</option>
													<option>화학물질</option>
													<option>기타</option>
												</select>
											</li>
											<li>
												<span>방제 현황</span>
												<select name="" style="width:180px">
													<option>전체</option>
												</select>
											</li -->
										</ul>
										<div class="btArea">
 											<a href="javascript:selectWaterPop('str');" class="btn roundBox" style="float:right;">조회</a>
											<input type="button" name="" value="조회" class="btn btn_search" onclick="$main.model.reloadData()" style="float:right;"/>
										</div>
	<!-- 									<div id="resultDiv"> </div> -->
									</div>
								</div>
								
								<div class="divideBx" ></div>
								
								<div id="chk">	
									<span class="title">측정소 범례</span>
									<div id="chkInfoBx" style="overflow: auto;">
									</div>
								</div>
							</div>
							<%-- <div id="typeCase" class="tabCase hide">
								<div  style="margin-left:2px;">
									<div id="stb01" class="stabMenu">
										<ul>
											<li>
												<span class="point">수계</span>
												<select name="" id="sugyeThemeSel" style="width:160px">
													<option value="R01">한강</option>
													<option value="R02">낙동강</option>
													<option value="R03">금강</option>
													<option value="R04">영산강</option>
												</select>
											</li>
											<li>
												<span class="point">유형</span>
												<select name="" id="themeSel" style="width:160px">
													<option value="1">환경기초시설</option>
													<option value="2">점오염원</option>
													<option value="3">취수정장</option>
												</select>
											</li>
											<li>
												<span class="point">항목</span>
												<select name="" id="themeItemSel" style="width:160px">
													<option value="20">농공단지폐수종말처리시설</option>
													<option value="21">기타공동처리시설</option>
													<option value="22">분뇨처리시설</option>
													<option value="23">산업폐수종말처리시설</option>
													<option value="24">매립장침출수처리시설</option>
													<option value="25">축산폐수공공처리시설</option>
													<option value="26">마을하수도</option>
													<option value="27">하수종말처리시설</option>
												</select>
											</li>
										</ul>
									</div>
								</div>
								<div style="padding-top:5px;height:25px;">
									<label for="" style="float:left;"><input type="checkbox" id="excessChk" checked="checked"/> 기준치 초과</label>
									<input type="button" id="searBtn" value="검색" class="btn btn_search" style="float:right" alt="검색"/>
<!-- 									<a href="javascript:;" id="searBtn" class="btn roundBox" style="float:right;">검색</a> -->
								</div>
								<div class="resultTit">
									검색결과
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									
									<label for="" style="float:none;">반경
										<select id="rangeSel" style="width:80px">
													<option value="5">5Km</option>
													<option value="10">10Km</option>
													<option value="15">15Km</option>
													<option value="20">20Km</option>
													<option value="30">30Km</option>
												</select>
										</label>
									<span id="resultCount" style="float: right;">총 0건</span>
								</div>
								<div id="resultBx">
								</div>
							</div> --%>
						</div>
					</div>
					<div id="searchToggle"><img src="/images/renewal2/toggle_in.png" alt="닫기"/></div>
				</div>
				<!--좌측 검색패널 End-->
				<div id="btTab">
					<div id="btTabToggle"><img src="/gis/images/toggle_rin.png" alt="닫기"/></div>
					<div class="tab_menu">
						<ul class="menuul">
							<li class="menuli on"><span>자동</span></li>
							<li class="menuli"><span>수동</span></li>
						</ul>
						<div style="display:block;">
							<ul>
								<li>
									<label><input type="radio" id="radiobutton1" name="radiobutton" value="radiobutton"/> 평시</label>
									<select id="roopSysKindSel" style="width:80px;float:right;">
										<option value="all">전&nbsp;&nbsp;체</option>
										<option value="A">자동측정망(A)</option>
										<option value="U">이동형측정기기(U)</option>
									</select>
								</li>
								<li><label><input type="radio" id="radiobutton2" name="radiobutton" value="radiobutton" /> 이상</label></li>
								<li><label><input type="radio" id="radiobutton3" name="radiobutton" value="radiobutton" /> 사고발생</label></li>
								<li>
									<input onclick="javascript:$main.model.prev()" type="button" name="" value="뒤로" class="autobtn" id="autobt01"/>
									<input onclick="javascript:$main.model.stop()" type="button" name="" value="일시정지" class="autobtn" id="autobt02"/>
									<input onclick="javascript:$main.model.play()" type="button" name="" value="재생" class="autobtn" id="autobt03"/>
									<input onclick="javascript:$main.model.next()" type="button" name="" value="앞으로" class="autobtn" id="autobt04"/>
									<input onclick="javascript:$main.model.refresh()" type="button" name="" value="앞으로" class="autobtn" id="autobt05"/>
								</li>
							</ul>
						</div>
						<div>
							<ul>
								<li>
									<label><input type="radio" id="radiobutton4" name="radiobuttonM" value="radiobutton" checked="checked"/> 평시</label>
<!-- 									<select id="roopSysKindSel"> -->
<!-- 										<option value="all">전 &nbsp; 체</option> -->
<!-- 										<option value="A">자동측정망(A)</option> -->
<!-- 										<option value="U">IP-USN(U)</option> -->
<!-- 									</select> -->
								</li>
								<li><label><input type="radio" id="radiobutton5" name="radiobuttonM" value="radiobutton"/> 이상</label></li>
								<li><label><input type="radio" id="radiobutton6" name="radiobuttonM" value="radiobutton"/> 사고발생</label></li>
								<li>
									<input onclick="javascript:$main.model.prev()" type="button" name="" value="뒤로" class="autobtn" id="autobt01"/>
<!-- 									<input onclick="javascript:$main.model.play()" type="button" name="" value="일시정지" class="autobtn" id="autobt02"/> -->
<!-- 									<input onclick="javascript:$main.model.stop()" type="button" name="" value="재생" class="autobtn" id="autobt03"/> -->
									<input onclick="javascript:$main.model.next()" type="button" name="" value="앞으로" class="autobtn" id="autobt04"/>
									<input onclick="javascript:$main.model.refresh()" type="button" name="" value="앞으로" class="autobtn" id="autobt05"/>
								</li>
							</ul>
						</div>
					</div>
<!-- 					<div id="btTabToggle"><img src="/gis/images/toggle_in.png" alt="닫기"/></div> -->
				</div>
				<!--우측 범례패널 Start-->
				<div id="berm">
					<ul>
						<li><span class="point1"></span>&nbsp;정상</li>
						<li><span class="point2"></span>&nbsp;관심</li>
						<li><span class="point3"></span>&nbsp;주의</li>
						<li><span class="point4"></span>&nbsp;경계</li>
						<li><span class="point5"></span>&nbsp;심각</li>
						<li><span class="point6"></span>&nbsp;미수집</li>
						<li><span class="point7"></span>&nbsp;점검중</li>
					</ul>
				</div>
				<!--우측 범례패널 End-->
			</div>
		</div>
		<!-- 4대강 유역 사고 발생 모니터링 영역 끝 -->
		
		<!-- 4대강 수질상황 감시 영역 -->
		<c:if test="${!empty TotalMntMainTS }">
		<div id="main_div_m2" style="display:none;">
			<form method="post" name="frm">
				<iframe id="ifrm" name="ifrm" width="1250" height="685" frameborder="0"></iframe> 
			</form>
		</div>
		</c:if>
		<!-- 4대강 수질상황 감시 영역 끝 -->
		
		<div id="main_div_m2" style="display:none;">
			<form method="post" name="_imagedownload_">
				<input type="hidden" id="_imageData_" name="_imageData_"></input>
				<iframe id="_imagedownloadFrame_" name="_imagedownloadFrame_" width="1250" height="685" frameborder="0"></iframe> 
			</form>
		</div>
		
		<!--하단 패널 Start-->
		<!-- Footer Start-->
		<div id="footer" style="z-index: 100">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
		<!-- 레이어 팝업 -->
		<div id="layerApprovalIns" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnGroInsXbox" name="btnGroInsXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerApprovalIns');" alt="닫기"/>
		</div>
		<table summary="결재대기"style="text-align:left;">
			<col width="400px" />
			<tr>
				<th scope="col" style="text-align:left; height:30px;">결재대기</th>
			</tr>
			<tr>
				<td style="text-align:left; height:80px;">결재대기 중인 문서가 있습니다.
				</td>
			</tr>
		</table>
		<div id="btCarea">
			<input type="button" id="btnCheck" name="btnCheck" value="확인" class="btn btn_white" onclick="javascript:approvalCheck();" alt="확인"/>
		</div>
	</div>
	</div>
</body>
</html>