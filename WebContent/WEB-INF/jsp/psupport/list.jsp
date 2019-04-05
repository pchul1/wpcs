<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : list.jsp
	 * Description : 사고지점정보 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author khany
	 * since 2013.10.20
	 * 
	 * Copyright (C) 2013 by lkh All right reserved.
	 */
%>
<%
String sURL = "/psupport/TMS_POP.jsp?menuID="+(String)request.getSession().getAttribute("clickMenu");
String menuID = (String)request.getSession().getAttribute("clickMenu");
// menuID = (String)request.getAttribute("menuID");
//$('#mapFrame').attr('src', '/psupport/TMS_Manage.html?menuID=${menuID} }'))
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/gis/css/gis_style.css'/>"/>
<!-- <link rel="stylesheet" href="http://js.arcgis.com/3.8/js/dojo/dijit/themes/claro/claro.css"> -->
<!-- <link rel="stylesheet" href="http://js.arcgis.com/3.8/js/esri/css/esri.css"> -->
<!-- <script type="text/javascript" src="/gis/gis/jsapi_vsdoc10_v36.js"></script> -->

<!-- <script src="http://js.arcgis.com/3.8/"></script> -->

<style>
.mapst {  position: absolute; right: 20px; top: 50px; }
.mapst li { float: left; }
.mapst li a { width: 73px; height: 28px; padding-top: 7px; display: block; font-size: 13px; letter-spacing: -1px; text-align: center; color: #bbb; background-position: -73px 0 !important; }
.mapst li a.basic { background: url(/gis/new_images/m_st_left.png); }
.mapst li a.stellite { background: url(/gis/new_images/m_st_right.png);}
.mapst li a.on { background-position: 0 0 !important; color: #fff; }
</style>

<script src="/gis/js/xml2json.js"></script>
<script src="/gis/js/common.js"></script>
<script src="/gis/js/new_kecoMap.js"></script>
<script src="/gis/js/list.js"></script>

<script type="text/javascript" src="/gis/new_js/lib/proj4.js" ></script>
<script type="text/javascript" src="/gis/new_js/lib/mapEventBus.js" ></script>
<!-- <script type="text/javascript" src="/gis/new_js/lib/ol/ol.js"></script> -->
<script type="text/javascript" src="http://tsauerwein.github.io/ol3/mapbox-gl-js/build/ol.js"></script>
 
<script type="text/javascript" src="/gis/new_js/lib/jsts/jsts.min.js"></script>

<script type="text/javascript" src="/gis/new_js/mapService.js"></script>
<script type="text/javascript" src="/gis/new_js/lib/vworldLayer.js"></script>
<script type="text/javascript" src="/gis/new_js/lib/coreMap.js"></script>

<style>

	/*20190403추가*/
.tooltip { position: absolute; right: 20px; top: 10px; background: #fff; }
.tooltip:after { display: block; clear: both; content: ''; }
.tooltip li { padding: 4px 8px 5px 6px; display: block; float: left; font-size: 11px; color: #434548; letter-spacing: -1px;border-left: 1px solid #0d0d0d; border-top: 1px solid #0d0d0d; border-bottom: 1px solid #0d0d0d; font-family: 'notokr-bold'; cursor: pointer; }
.tooltip li:last-child { border-right: 1px solid #0d0d0d; }
.tooltip li.on {background: #1388e6;color: #fff;}
.tooltip li> span { width: 21px; height: 16px; display: inline-block; margin-right: 3px; margin-bottom: -4px; background-position: 0 0; background-repeat: no-repeat; }
.tooltip li.on> span { background-position: -21px 0px; }
	
	
</style>
<script type="text/javascript">
	var MENU_ID = request.getParameter('menuID');
	
// 	function ps_accident_popup(){
// 		var sw=screen.width;
// 		var sh=screen.height;
// 		var winHeight = 890;
// 		var winWidth = 1260;
// 		var winLeftPost = (sw - winWidth) / 2;
// 		var winTopPost = 0;
// 		var width = winWidth-20;
// 		var height = winHeight-20;
		
// 		window.open("/psupport/TMS_POP.jsp?menuID=5110", 
// 				'psView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
// 	}
	
// 	function ps_ipusn_popup(){
// 		var sw=screen.width;
// 		var sh=screen.height;
// 		var winHeight = 890;
// 		var winWidth = 1260;
// 		var winLeftPost = (sw - winWidth) / 2;
// 		var winTopPost = 0;
// 		var width = winWidth-20;
// 		var height = winHeight-20;
		
// 		window.open("/psupport/TMS_POP.jsp?menuID=5120", 
// 				'psView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
// 	}
	
// 	function ps_sphone_popup(){
// 		var sw=screen.width;
// 		var sh=screen.height;
// 		var winHeight = 890;
// 		var winWidth = 1260;
// 		var winLeftPost = (sw - winWidth) / 2;
// 		var winTopPost = 0;
// 		var width = winWidth-20;
// 		var height = winHeight-20;
		
// 		window.open("/psupport/TMS_POP.jsp?menuID=5130", 
// 				'psView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
// 	}
	
	function popupOpen(){
		window.open("/psupport/TMS_POP.jsp?riverid="+user_riverid, 
				'psView','width='+window.screen.width+',height='+window.screen.height+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left=0,top=0');
	}
	
	$(function() {
		
		_CoreMap.init('map',{
			satellite: true
		});
		
		
	});
	$(window).load(function(){
		popupOpen();
	});
</script>
</head>

<body>
	<div id="wrap">
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->
		
		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">
				
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->
				
				<!-- Content Start-->
				<div id="content">
					
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
					
					<!--tab Contnet Start-->
					<div class="tab_container">
						<div class="mapBx" style=height:600px;>
							<div id="map" class="claro" style="width:100%; height:100%; border:1px solid #000; position:relative;">
								
							</div>
						</div>
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->
		
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
</body>
</html>